shader_type spatial;

uniform sampler2D viewport_texture;
uniform vec2 top_left;
uniform vec2 top_right;
uniform vec2 bottom_left;
uniform vec2 bottom_right;

void fragment(){
//	float y_min = top_left.y + (SCREEN_UV.x-top_left.x)/(top_right.x-top_left.x) * (top_right.y-top_left.y);
//	float y_max = bottom_left.y + (SCREEN_UV.x-bottom_left.x)/(bottom_right.x-bottom_left.x) * (bottom_right.y-bottom_left.y);
//
//	float x_min = top_left.x + (SCREEN_UV.y-top_left.y)/(bottom_left.y-top_left.y) * (bottom_left.x-top_left.x);
//	float x_max = top_right.x + (SCREEN_UV.y-top_right.y)/(bottom_right.y-top_right.y) * (bottom_right.x-top_right.x);
//	if(SCREEN_UV.y > y_min && SCREEN_UV.y < y_max && SCREEN_UV.x > x_min && SCREEN_UV.x < x_max){
//		ALBEDO = texture(viewport_texture, SCREEN_UV).rgb;
//	}
	ALBEDO = texture(viewport_texture, SCREEN_UV).rgb;
}