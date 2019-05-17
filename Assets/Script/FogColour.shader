Shader "Custom/NewSurfaceShader"
{
    Properties
    {
	// variablename ("displayName", dataType) = value
	//Dont semi colon this part
	_MainTex("Diffuse Texture", 2D) = "white"{} //a 2D Texture
	// _NormalTexture("Normal Texture", 2D) = "bump"{}
	_FogColor("Fog Colour", Color) =(1,1,1,1)
    }
	SubShader
	{
 		Tags
		{"RenderType" = "Opaque"}
		//SEMI COLON FROM HERE
		CGPROGRAM
		//tells us the type of shader
		#pragma surface mainColour Lambert finalcolor:fogcolour vertex:vert
		//connects the variableName to the CG code
		sampler2D _MainTex;
		//sampler2D _NormalTexture;
		fixed4 _FogColor;


		struct Input
		{
		//UV coordinates
		float2 uv_MainTex;
		half fog;
		};
		void vert(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float4 hpos = UnityObjectToClipPos(v.vertex);
			hpos.xy /= hpos.w;
			data.fog = min(1,dot(hpos.xy,hpos.xy)*0.5);
		}
		void fogcolour(Input IN, SurfaceOutput o,inout fixed4 colour)
		{
			fixed3 fogColour = _FogColor.rgb;
			#ifdef UNITY_PASS_FORWARDADD
			fogColour = 0;
			#endif
			colour.rgb = lerp(colour.rgb, fogColour, IN.fog);
		}
		void mainColour(Input IN, inout SurfaceOutput o)
		{
		o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
		//NO MORE SEMI COLON
	}
	Fallback "Diffuse"
	
}