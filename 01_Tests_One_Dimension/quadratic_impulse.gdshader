shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 line_color : source_color = vec4(vec3(1.0), 1.0);
uniform float line_width : hint_range(0.0, 1.0) = 0.04;
uniform float line_smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float taille_graph : hint_range(0.5, 20.0) = 3.0;
uniform float falloff : hint_range(0.0, 10.0);
uniform float speed : hint_range(0.0, 2.0) = 1.0;

float quadratic_impulse(float x, float k){
	return 2.0 * sqrt(k) * x/(1.0 + k * x * x);
}

float f(vec2 uv){
	return abs(quadratic_impulse(-uv.x, falloff * abs(cos(TIME * speed))) - uv.y);
}

void fragment() {
	float mix_value = smoothstep(line_width, line_smoothness,
		f(taille_graph / 2.0 - UV * taille_graph));
	
	COLOR = mix(bg_color, line_color, mix_value);
}