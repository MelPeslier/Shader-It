shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 color1 : source_color = vec4(1.0, 0.51, 0.37, 1.0);
uniform vec4 color2 : source_color = vec4(0.63, 0.0, 0.055, 1.0);
uniform vec4 indice_color : source_color = vec4(1.0);
uniform float line_width : hint_range(0.0, 1.0) = 0.04;
uniform float line_smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float speed : hint_range(0.1, 2.0) = 0.2;

float f(float x, float y){
	return sin((x * PI) / 2.0) 
	- (1.0 - y);
}

float sinOut(float t){
	return sin((t * PI) / 2.0);
}

float indice(float x, float y){
	float rayon = 0.01;
	float centre_x = sinOut(abs(fract(TIME * speed) * 2.0 - 1.0));
	float centre_y = f(x, y) + y;
	return (
		pow(rayon, 2.0) - pow(x - centre_x, 2.0) 
		- pow(y - centre_y, 2.0)
	);
}

void fragment() {
	vec4 line_color = mix(color1, color2, UV.x);
	float draw_mix_value = smoothstep(line_width, line_smoothness, abs(
		f(UV.x, UV.y)
	));
	vec4 tex1 = mix(bg_color, line_color, draw_mix_value);
	
	float indice_width = line_width / 10.0;
	float indice_smoothness = indice_width - 0.001;
	float indice_mix_value = smoothstep(indice_width, indice_smoothness, abs( 
		indice(UV.x, UV.y)
	));
	vec4 tex2 = mix(bg_color, indice_color, indice_mix_value);
	
	COLOR = tex1 + tex2;
}
