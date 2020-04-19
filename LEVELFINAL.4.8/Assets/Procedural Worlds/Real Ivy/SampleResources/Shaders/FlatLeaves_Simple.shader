Shader "Real Ivy/Flat leaves simple"
{
	Properties
	{
		_AlbedoTexture("Albedo Texture", 2D) = "white" {}
		_Cutoff( "Cutout Value", Float ) = 0.5
		_WindPattern("Wind Pattern", 2D) = "white" {}
		_Frequency("Frequency", Float) = 1
		_Amplitude("Amplitude", Float) = 1
		_Center("Center", Float) = 0
		_Radius("Radius", Float) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WindPattern;
		uniform float _Frequency;
		uniform float _Amplitude;
		uniform float _Center;
		uniform float _Radius;
		uniform sampler2D _AlbedoTexture;
		uniform float4 _AlbedoTexture_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 appendResult87 = (float4(ase_vertex3Pos.x , ase_vertex3Pos.y , 0.0 , 0.0));
			float temp_output_66_0 = ( _Time.y * _Frequency );
			float4 appendResult94 = (float4(temp_output_66_0 , ( temp_output_66_0 / 2.0 ) , 0.0 , 0.0));
			float4 temp_output_63_0 = ( ( tex2Dlod( _WindPattern, float4( ( appendResult87 + appendResult94 ).xy, 0, 0.0) ) * _Amplitude ) + ( ( UNITY_PI + _Center ) / 2.0 ) );
			float3 ase_vertexNormal = v.normal.xyz;
			float4 ase_vertexTangent = v.tangent;
			v.vertex.xyz += ( ( cos( temp_output_63_0 ) * float4( ase_vertexNormal , 0.0 ) * _Radius * v.color.a ) + ( ( sin( temp_output_63_0 ) + -1.0 ) * float4( cross( ase_vertexNormal , ase_vertexTangent.xyz ) , 0.0 ) * _Radius * v.color.a ) ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			float4 tex2DNode76 = tex2D( _AlbedoTexture, uv_AlbedoTexture );
			o.Albedo = tex2DNode76.rgb;
			o.Alpha = 1;
			clip( tex2DNode76.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}