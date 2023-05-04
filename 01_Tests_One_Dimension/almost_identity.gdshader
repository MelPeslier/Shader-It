shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 line_color : source_color = vec4(vec3(1.0), 1.0);
uniform float line_width : hint_range(0.0, 1.0) = 0.04;
uniform float line_smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float taille_graph : hint_range(0.5, 20.0) = 3.0;
uniform float treshold : hint_range(0.0, 1.0);
uniform float new_value : hint_range(0.0, 1.0);

float almost_identity(float x, float m, float n){
	if (x>m){
		return x;
	}
	float a = 2.0 * n - m;
	float b = 2.0 * m - 3.0 * n;
	float t = x/m;
	return (a * t + b) * t * t + n;
}

float f(vec2 uv){
	return abs(almost_identity(uv.x, cos(treshold + TIME / 2.0), sin(new_value + TIME / 1.5)) - uv.y);
}

void fragment() {
	float mix_value = smoothstep(line_width, line_smoothness,
		f(taille_graph / 2.0 - UV * taille_graph));
	
	COLOR = mix(bg_color, line_color, mix_value);
}
