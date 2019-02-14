shader_type spatial;
render_mode unshaded;

uniform sampler2D viewport_texture;
//uniform float recursion_level = 0f;

void fragment(){
//	vec2 real_uv = UV;
//	real_uv.y = 1f-UV.y;
//	real_uv = (INV_CAMERA_MATRIX * vec4(real_uv, 0.0, 0.0)).xy;
//	ALBEDO = textureLod(viewport_texture, SCREEN_UV, recursion_level).rgb;
	ALBEDO = texture(viewport_texture, SCREEN_UV).rgb;
	//ALBEDO.r = DEPTH;
}