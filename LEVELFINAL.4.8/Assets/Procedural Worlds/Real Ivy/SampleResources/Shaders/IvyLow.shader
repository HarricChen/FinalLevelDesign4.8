Shader "Real Ivy/Ivy Low"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_AlbedoTexture("Albedo Texture", 2D) = "white" {}
		_NormalTexture("Normal Texture", 2D) = "bump" {}
		_Specular("Specular", Range( 0 , 1)) = 0
		_SpecularTexture("Specular Texture", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
		};

		uniform sampler2D _NormalTexture;
		uniform float4 _NormalTexture_ST;
		uniform sampler2D _AlbedoTexture;
		uniform float4 _AlbedoTexture_ST;
		uniform sampler2D _SpecularTexture;
		uniform float4 _SpecularTexture_ST;
		uniform float _Specular;
		uniform float _Smoothness;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_NormalTexture = i.uv_texcoord * _NormalTexture_ST.xy + _NormalTexture_ST.zw;
			float3 tex2DNode103 = UnpackNormal( tex2D( _NormalTexture, uv_NormalTexture ) );
			float4 appendResult132 = (float4(tex2DNode103.r , tex2DNode103.g , ( tex2DNode103.b * i.ASEVFace ) , 0.0));
			o.Normal = appendResult132.xyz;
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			float4 tex2DNode76 = tex2D( _AlbedoTexture, uv_AlbedoTexture );
			o.Albedo = tex2DNode76.rgb;
			float2 uv_SpecularTexture = i.uv_texcoord * _SpecularTexture_ST.xy + _SpecularTexture_ST.zw;
			o.Specular = ( tex2D( _SpecularTexture, uv_SpecularTexture ) * _Specular ).rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
			clip( tex2DNode76.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}