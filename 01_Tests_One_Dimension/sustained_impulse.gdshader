shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 line_color : source_color = vec4(vec3(1.0), 1.0);
uniform float line_width : hint_range(0.0, 1.0) = 0.04;
uniform float line_smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float taille_graph : hint_range(0.5, 20.0) = 3.0;
uniform float attack_width : hint_range(0.1, 5.0) = 1.0;
uniform float release : hint_range(0.1, 30.0) = 2.0;


float polynomial_impulse(float x, float f, float k){
	float s = max(x - f, 0.0);
	return min(x * x / (f * f), 1.0 + (2.0 / f) * s * exp(-k * s));
}

float f(vec2 uv){
	return abs(polynomial_impulse(-uv.x, attack_width , release) - uv.y);
}

void fragment() {
	float mix_value = smoothstep(line_width, line_smoothness,
		f(taille_graph / 2.0 - UV * taille_graph));
	
	COLOR = mix(bg_color, line_color, mix_value);
}