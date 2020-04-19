using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class _UI_Animator : MonoBehaviour
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

    public void SlideRight()
    {
        anim.Play("_uianim_SlidetoRight");
    }

    public void SlideLeft()
    {
        anim.Play("_uianim_SlidetoLeft");
    }

    public void SunStartGo()
    {
        anim.Play("_Ligpht_Start_Go");
    }

    public void SunStartBack()
    {
        anim.Play("_Ligpht_Start_Back");
    }
}

