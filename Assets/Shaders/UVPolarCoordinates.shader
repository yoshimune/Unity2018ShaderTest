Shader "Unlit/UVPolarCoordinates"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#define PI 3.1415926535
			
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

			sampler2D _MainTex;
			float4 _MainTex_ST;

			inline float4 CartesianToPolar(float2 uv) {
				// [0,1]の範囲を[-1,1]に変更する
				float2 rangeUV = uv * 2 - float2(1,1);

				float y = sqrt(pow(rangeUV.x, 2) + pow(rangeUV.y, 2));
				float x = atan(rangeUV.y / rangeUV.x) / (PI * 2);
				
				return float4(x, y, 0, 0);
			}
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, CartesianToPolar(i.uv));
				return col;
			}
			ENDCG
		}
	}
}
