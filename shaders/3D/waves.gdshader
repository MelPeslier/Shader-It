shader_type spatial;
//Depth test disabmed is here so we can see the mesh even behind any parents
render_mode blend_add, cull_disabled, shadows_disabled, unshaded;
// Shadows disabled mean that no other object can cast a shadow on it
// Unshaded : full color, no light alter it

uniform float time_speed : hint_range(0.0, 1.0) = 1.0;
uniform vec4 albedo_start : source_color;
uniform vec4 albedo_end : source_color;
//uniform float color_start : hint_range(0.0, 1.0) = 0.0;
//uniform float color_end : hint_range(0.0, 1.0) = 1.0;
//uniform vec4 albedo : source_color;
//uniform sampler2D depth_tex : hint_depth_texture;
//uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

// for passing the local NORMAL from the vertex to the fragment
varying vec3 norm;

//vec4 lerp_color(vec4 A, vec4 B, float t) {
//	return (A + (B - A) * t);
//}

//float inverseLerp(float start, float end, float t) {
//	return (t - start) / (end - start);
//}

void vertex() {
// NORMAL in vertex is the normal of the local transform
	norm = NORMAL;
}

void fragment() {
	float time = TIME * time_speed;
	float x_offset = cos( (UV.x) * TAU * 8.0) * 0.01;
	float t = cos( ( UV.y + x_offset + time) * TAU * 8.0 ) * 0.5 + 0.5;
	
	float top_to_bottom = UV.y;
	float bottom_to_top = 1.0 - UV.y;
	
	t *= top_to_bottom;
	
//		Pour ne pas afficher la face qui pointe vers le haut ou le bas : z et -z
	float topBottomRemover = ( abs(norm.y) < 0.999 ? 1.0 : 0.0);
	float waves = t * topBottomRemover;
	
//		ALBEDO = vec3(waves);
	vec4 gradient = mix(albedo_start, albedo_end, bottom_to_top);
	ALBEDO = gradient.rgb * waves;


//	vec4 albedo_tex = texture(texture_albedo, UV);

// Not in the fragment, where it is converted to the world transform
//	ALBEDO = norm;
//	ALBEDO = albedo.rgb * albedo_tex.rgb;
//	float t = (UV.x + UV.y) / 2.0;
//	float t = UV.x;
//	float t = smoothstep(color_start, color_end, UV.x);
//	float t = inverseLerp(color_start, color_end, UV.x);
//	t = clamp(0, 1, t);
//	float t = abs( fract( UV.x * 5.0 ) * 2.0 - 1.0 );

//	Candy Pattern *****
//	float x_offset = UV.y + cos( UV.y * TAU * 8.0 ) * 0.01;
//	float t = cos( ( UV.x + x_offset ) * TAU * 8.0 );
//	*****

//	float time = TIME * time_speed;
//	float x_offset = cos( (UV.x) * TAU * 8.0) * 0.01;
//	float t = cos( ( UV.y + x_offset + time) * TAU * 8.0 ) * 0.5 + 0.5;
//	t *= UV.y;
//	t *= ( abs(norm.y) < 0.999 ? 1.0 : 0.0);
//
////	vec4 out_color = lerp_color(albedo_start, albedo_end, t);
//	vec4 out_color = mix(albedo_start, albedo_end, t);
//	ALBEDO = out_color.rgb;

//	ALBEDO = UV.xxx;
//	ALPHA = transparency;
}
