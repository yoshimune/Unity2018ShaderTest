Shader "Custom/Butterfly_Legacy" {
	Properties {
		[HDR]
		_Color("Color", Color) = (1,1,1,1)
		_ColorZ("ColorZ", Color) = (1,1,1,1)
		_Z("Z", Range(1,1000)) = 1
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_AlphaCutoff ("AlphaCutoff", Range(0,1)) = 0.3
		_Speed("Speed", Range(0,20)) = 1.0
		_Offset("Offset", Range(0,1)) = 1.0
		_OffsetRotate("OffsetRotate", Range(0,3.14)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" "DisableBatching" = "True" }
		Cull Off
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard vertex:vert alphatest:_AlphaCutoff
//#pragma multi_compile_instancing
//#pragma instancing_options procedural:vertInstancingSetup
//#pragma exclude_renderers gles
#include "UnityStandardParticleInstancing.cginc"
#include "UnityCG.cginc"
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _CameraDepthTexture;

		struct Input {
			float2 uv_MainTex;
			float2 uv_CameraDepthTexture;
			fixed4 vertexColor;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _ColorZ;
		float _Speed;
		float _Offset;
		float _Z;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_DEFINE_INSTANCED_PROP(float, _OffsetRotate)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert(inout appdata_full v, out Input o) {
			float offset = UNITY_ACCESS_INSTANCED_PROP(Props, _OffsetRotate);
			float theta = (((step(v.vertex.x, 0) * 2) - 1) * sin((_Time.y * _Speed + offset)));
			float2x2 rotation = float2x2(cos(theta), -sin(theta), sin(theta), cos(theta));
			float2 xz = mul(rotation, v.vertex.xz) + float2(0, sin(_Time.y * _Speed) * _Offset + offset);
			v.vertex.xyz = float3(xz.x, v.vertex.y, xz.y);

			UNITY_INITIALIZE_OUTPUT(Input, o);
			//vertInstancingColor(o.vertexColor);
			//vertInstancingUVs(v.texcoord, o.uv_MainTex);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			// デプス
			float depth = saturate(length(_WorldSpaceCameraPos.xyz - IN.worldPos) / _Z);
			fixed3 zcolor = fixed3(1, 1, 1) - depth * (fixed3(1, 1, 1) - _ColorZ.rgb);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color * (fixed4(zcolor, 1));
			o.Albedo = c.rgb;
			o.Emission = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
