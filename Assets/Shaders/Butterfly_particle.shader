Shader "Custom/Butterfly_particle"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[HDR]
		_Color("Color", Color) = (1,1,1,1)
		[HDR]
		_ColorZ("ColorZ", Color) = (1,1,1,1)
		_Z("Z", Range(0.001,10)) = 1
		_Speed("Speed", Range(0,20)) = 1.0
		_Offset("Offset", Range(0,0.03125)) = 0.001
		_OffsetRotate("OffsetRotate", Range(0,3.14)) = 1.0
		_Cutoff ("Alpha Cut off", Range(0,1)) = 0.3
	}
	SubShader
	{
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" }
		LOD 100

		Pass
		{
			Tags { "LightMode"="ForwardBase" }
			Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
#pragma multi_compile_instancing
#pragma instancing_options procedural:vertInstancingSetup
			
			#include "UnityCG.cginc"
#include "UnityStandardParticleInstancing.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 worldPos : TEXCOORD1;
				//UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			//UNITY_INSTANCING_BUFFER_START(Props)
			//UNITY_DEFINE_INSTANCED_PROP(float, _OffsetRotate)
			//UNITY_INSTANCING_BUFFER_END(Props)

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _Color;
			fixed4 _ColorZ;
			float _Speed;
			float _Offset;
			float _Z;
			float _OffsetRotate;

			float _Cutoff;

			v2f vert (appdata v)
			{
				v2f o;

				UNITY_SETUP_INSTANCE_ID(v);
				//UNITY_TRANSFER_INSTANCE_ID(v, o); // necessary only if you want to access instanced properties in the fragment Shader.
				//float offset = UNITY_ACCESS_INSTANCED_PROP(Props, _OffsetRotate);
				float offset = _OffsetRotate;
				
				// ローカル座標で羽ばたきアニメーションする
				// x座標が0未満の場合は-1,0以上の場合は1を乗算して回転方向を逆にしている
				float theta = (((step(v.vertex.x, 0) * 2) - 1) * sin((_Time.y * _Speed + offset)));
				float2x2 rotation = float2x2(cos(theta), -sin(theta), sin(theta), cos(theta));
				float2 xz = mul(rotation, v.vertex.xz) + float2(0, sin(_Time.y * _Speed + offset) * _Offset);
				float4 vpos = float4(xz.x, v.vertex.y, xz.y, 1);

				o.vertex = UnityObjectToClipPos(vpos);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				o.worldPos = mul(unity_ObjectToWorld, vpos);
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				//UNITY_SETUP_INSTANCE_ID(i); // necessary only if any instanced properties are going to be accessed in the fragment Shader.

				// デプス
				float depth = saturate(length(_WorldSpaceCameraPos.xyz - i.worldPos.xyz) / _Z);
				half4 texColor = tex2D(_MainTex, i.uv);
				half4 mainColor = texColor * _Color;
				half4 zColor = texColor * _ColorZ;
				half4 col;
				col.rgb = mainColor.rgb + (depth * (zColor.rgb - mainColor.rgb));
				col.a = mainColor.a;
				clip(col.a - _Cutoff);
				return col;
			}
			ENDCG
		}
	}
}
