/* Use syntax "BLEND SRCFACTOR DSTFACTOR" to determine how we want to blend the color we calculated 
 * with the origin color in frame buffer.
 * Common factors include:
 *   One, Zero, SrcAlpha, SrcColor, DstAlpha, DstColor, OneMinusSrcColor ...
 */

 /*
    Common blend factors:
    Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
    Blend One OneMinusSrcAlpha // Premultiplied transparency
    Blend One One // Additive
    Blend OneMinusDstColor One // Soft Additive
    Blend DstColor Zero // Multiplicative
    Blend DstColor SrcColor // 2x Multiplicative
   */

// regular AlphaBlending:
/* 
Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }

ZWrite Off
Blend SrcAlpha OneMinusSrcAlpha // determined by source Alpha value
*/
// Alpha test creates more sharp image
// For objects with almost opaque appearance(a bit semitransparent edges) we can use 
// multisample anti-aliasing (MSAA); 
// AlphaToMask On: Turns on alpha-to-coverage. When MSAA is used, alpha-to-coverage modifies 
// multisample coverage mask proportionally to the pixel Shader result alpha value. 
// This is typically used for less aliased outlines than regular alpha test; 
// useful for vegetation and other alpha-tested Shader



Shader "Custom/BlendShaders"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "black" {}
        _Color ("Main Color", Color) = (1, 1, 1 ,1)
    }

    SubShader
    {
        Tags{ "Queue" = "Transparent"}
        Material
                {
                    Diffuse [_Color]  
                    Ambient [_Color] 
                }
 
        Lighting On
        Pass
        {
            Blend OneMinusDstColor One // Soft Additive
           
            SetTexture [_MainTex] {
                constantColor [_Color]
                combine constant lerp(texture) previous}

        }
    }

}