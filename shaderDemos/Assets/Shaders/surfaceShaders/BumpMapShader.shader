Shader "Custom/BumpMapShader" 
{
    Properties 
    {
        _MainTex ("Texture", 2D) = "white" {}
        // a (normally) balck and white texture map known as the height map
        _BumpMap ("Bumpmap Texture", 2D) = "bump" {}
        _RimColor ("Rim Color", Color) = (0.17,0.36,0.81,0.0)
        _RimPower ("Rim Power", Range(0.6,9.0)) = 1.0
    }

    SubShader 
    {
        Tags { "RenderType" = "Opaque" }

        CGPROGRAM

        #pragma surface surf Lambert
        
        struct Input 
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
        };

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float4 _RimColor;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
            // the rgb value comes from main texture while the normal comes from the bump map
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
            // rim color's saturation is related to view direction
            half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow (rim, _RimPower);
        }

        ENDCG
    } 
    Fallback "Diffuse"
}

