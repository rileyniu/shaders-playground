using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PostEffectScript : MonoBehaviour {

    public Material mat;

    void OnRenderImage(RenderTexture src, RenderTexture dest){
        //src is the fully rendered scene that would normally be sent directly to
        // the monitor; we are intercepting this so we can do a bit more work

        //bad to do image effect here insteand of CPU

        //allocating millions bytes every frame
        // Color[] pixels = new Color[1920 * 1089];
        // then use a nested forloop to update the pixels - really bad

        Graphics.Blit(src, dest, mat);
       
    }
}
