Shader "Unlit/UVTest"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_UV_Offset ("Offset", Vector) = (1,1,1,1)
		_UV_Scale("Scale", Vector) = (1,1,1,1)
		_UV_Rotation("Rotation", Float) = 0
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

			float4 _UV_Offset;
			float4 _UV_Scale;
			float _UV_Rotation;
			

			inline float4 calcUV(float2 uv) {
				float3x3 scale = float3x3(
					_UV_Scale.x, 0, 0,
					0, _UV_Scale.y, 0,
					0, 0, 1);
				float3x3 offset = float3x3(
					0, 0, _UV_Offset.x,
					0, 0, _UV_Offset.y,
					0, 0, 0);
				float3x3 rotation = float3x3(
					cos(_UV_Rotation), -sin(_UV_Rotation), 0,
					sin(_UV_Rotation), cos(_UV_Rotation), 0,
					0, 0, 1);

				//float3x3 trans = scale + offset + rotation;
				float3 baseUV = float3(uv.x, uv.y, 1);

				float3x3 rotationTrans = rotation;
				float3x3 scaleOffsetTrans = scale + offset;

				return float4(mul(scaleOffsetTrans, mul(rotationTrans, baseUV)), 1);
			}

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = calcUV(v.uv);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}

			ENDCG
		}
	}
}
