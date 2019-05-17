Shader "Custom/NewSurfaceShader"
{
    Properties
    {
	// variablename ("displayName", dataType) = value
	//Dont semi colon this part
	_MainTexture("Diffuse Texture", 2D) = "white"{} //a 2D Texture
	_NormalTexture("Normal Texture", 2D) = "bump"{}
	_TintColour ("Tint", Color) = (0,0,0,0)
    }
	SubShader
	{
 		Tags
		{
			"RenderType" = "Opaque"

		}
		//SEMI COLON FROM HERE
		CGPROGRAM
		//tells us the type of shader
		#pragma surface surf Lambert finalcolor:mycolour
		//connects the variableName to the CG code
		sampler2D _MainTexture;
		sampler2D _NormalTexture;
		fixed4 _TintColour;

		struct Input
		{
		//UV coordinates
		float2 uv_MainTexture;
		float2 uv_NormalTexture;
		};
		void mycolour(Input IN, SurfaceOutput o, inout fixed4 colour)
		{
		colour *= _TintColour;
		}
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTexture, IN.uv_MainTexture).rgb;
			o.Normal = UnpackNormal(tex2D(_NormalTexture,IN.uv_NormalTexture));
		}
		ENDCG
		//NO MORE SEMI COLON
	}
	Fallback "Diffuse"
	
}
