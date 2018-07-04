Shader "Custom/VegetationShader" 

// When blending trees, alphaTest results in some undesirable sharp edge,
// to avoid this we render twice; the first time focuses on 
// concrete values, and the second time we use AlphaBlend on 
// the rest part.
{
	Properties
	{
        // Shader properties
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaCutOff ("Alpha Cutoff", Range(0, 0.9)) = 0.5
	}
	SubShader
	{
		Cull Off

		Lighting On

		Material
		{
			Diffuse [_Color]
			Ambient [_Color]
		}

        // Shader code

		// The first pass is for rendering all concrete pixels
		Pass
        {
			AlphaTest Greater [_AlphaCutOff]
			SetTexture [_MainTex] {
				// combine main texture with lighting colors
				combine primary * texture
			}
		}

		Pass 
		{
			ZWrite Off
			//ZTest Less
			AlphaTest LEqual [_AlphaCutOff]
			Blend SrcAlpha OneMinusSrcAlpha
			SetTexture [_MainTex]
			{
				combine texture * primary, texture
			}
		}
	} 
}
