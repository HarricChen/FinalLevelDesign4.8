using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class _UI_Light_Animation : MonoBehaviour
{
    public Animator anim;
    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {

    }


    public void SunStartGo()
    {
        anim.Play("_Light_Start_Go");
    }

    public void SunStartBack()
    {
        anim.Play("_Light_Start_Back");
    }

    public void SunSettingGo()
    {
        anim.Play("_Light_Setting_Go");
    }

    public void SunSettingBack()
    {
        anim.Play("_Light_Setting_Back");
    }
}
