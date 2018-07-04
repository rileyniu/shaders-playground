Shader "Custom/AlphaBlendShader" 


// TEXTURE COMBINATIONS
// - combine src1 * src2 - darker
// - combine src1 + src2 - brighter
// - combine src1 - src2
// - combine src1 +- src2
// - combine src1 lerp (src2) src3
//   使用源2的透明度通道值在源3和源1中进行差值，注意差值是反向的：当透明度值是1是使用源1，透明度为0时使用源3
// - combine src1 * src2 +- src3

// where src can be:
// - Previous: last result of SetTexture
// - Primary: from light calc
// - Texture: from current SetTexture
// - Constant: defined by ConstantColor

{
	Properties
	{
        // Shader properties
		_Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Highlight", Color) = (1,1,1,1)
        _Emission ("Emission", Color) = (0,0,0,0)
        _Shininess ("Shininess", Range (0.01, 1)) = 0.7
		_MainTex ("Base Texture)", 2D) = "white" {}
        _BlendTex ("Blend Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
        {

            Material
            {
                Diffuse [_Color]
                Ambient [_Color]
                Shininess [_Shininess]
                Specular [_SpecColor]
                Emission [_Emission]
            }
            //开启光照
            Lighting On
            //开启独立镜面反射
            SeparateSpecular On
            //设置纹理并进行纹理混合
            SetTexture [_MainTex] 
            {
                //use DOUBLE to add extra shininess
                Combine texture * primary DOUBLE/*, texture * primary*/
            }

            // blend a second texture
			//SetTexture[_BlendTex] {combine texture * previous}

		}
	} 
}


