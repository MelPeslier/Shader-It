shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform sampler2D curve;

void fragment() {
	vec2 vec_to_center = vec2(0.5, 0.5) - UV;
	float dist_to_center = length(vec_to_center);
	float curve_val =  texture(curve, vec2(dist_to_center)).r;
	vec2 diff = normalize(vec_to_center) * -0.2 * curve_val;
	COLOR = texture(screen_texture, SCREEN_UV - diff);
}
