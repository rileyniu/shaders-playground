// NOTE: Whether this shader is visible in the Unity menu

Shader "Custom/PostEffectShader"
{
	Properties
    // NOTE: how we interact with things
	{

    // NOTE: define the properties
		_MainTex ("Main Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
        // NOTE: where the program actually starts
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

            // NOTE: get called for each vertice in the object, manipulate vertice
            // information or add more data
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

            // NOTE: runs once for every pixel, tells video card what color should it be
            // NOTE: doing math here is much more fast
			fixed4 frag (v2f i) : SV_Target
            
			{
                // right now the main texture is just the screen, its getting the
                // color of the texture on that coordinate

                // fixed4: fixed is a number type ranged from -2 to 2

                // added sin wave to cause distortion

                //tex2D return a float4 RGBalpha value

                // added time parameter to tell the shader how much time has passed
                // since the program started; 
                // _Time[?] is an array - the number of seconds * x

                // added randomnes: 


				fixed4 col = tex2D(_MainTex, i.uv +float2(0, sin(i.vertex.x/50 + _Time[1])/10));
               
                
                
				// just invert the colors
				// col.rgb = 1 - col.rgb;
                col.r = 1;
				return col;
			}
			ENDCG
		}
	}
}




// NOTE: UI elements: 2dSprite, cannot be used with 3d materizl/normal shader
// because there's no light on 2d elements
// should use UNLIT SHADER: no lights need to be involved
// could use Unity's built-in default UI shader

/* 

Properties {
    _NoiseTex ("Noise Texture", 2D) = "white" {}
    _DistortionDamper ("Distortion Damper", Float) = 10
}

//to use in frag:
//declare in CG range and directly reference it in frag()
sampler2D _NoiseTex;

//parameters that can be tuned 
float _DistortionDamper;
float _DistortionSpreader;

// add noise offset to the edge of the image

float2 offset = float2(
    // flow motion
    tex2D(_NoiseTex, float2(i.worldPosition.y/ _DistortionSpreader + _Time[1], 0).r),
    tex2D(_NoiseTex, float2(0, i.worldPosition.x/ _DistortionSpreader + _Time[1])).r,
    ); //only use the red value

    //random motion
    tex2D(_NoiseTex, float2(_Time[1]/20, i.worldPosition.x/ _DistortionSpreader)).r

    //center the offset
    offset -=0.5;

//UI shader can also be applied to text since it's 2d element

*/