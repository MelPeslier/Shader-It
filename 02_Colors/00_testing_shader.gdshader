shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 color1 : source_color = vec4(1.0, 0.51, 0.37, 1.0);
uniform vec4 color2 : source_color = vec4(0.63, 0.0, 0.055, 1.0);
uniform vec4 indice_color : source_color = vec4(1.0);
uniform float line_width : hint_range(0.0, 1.0) = 0.04;
uniform float line_smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float speed : hint_range(0.1, 2.0) = 0.2;

float f(vec2 uv){
	/* Au lieu d'utiliser 'x - y', on utilise 'x - (1 - y)'
	Pour inverser la coordonnée du y, car elle commence en haut avec UV
	Et on veut qu'elle commence en bas comme dans les graphs de base */
	uv.xy = vec2 (uv.x, uv.y);
	return uv.x < 0.0001 || uv.x > 0.9999
		? uv.x - uv.y 
		: ( uv.x < 0.5
			? +0.5 * pow(2.0, 20.0 * uv.x - 10.0) - (1.0 - uv.y)
			: -0.5 * pow(2.0, 10.0 - (20.0 * uv.x)) + 1.0 - (1.0 - uv.y)
		);
}

float exponentialInOut(float t){
// Using ternary operators. '()' needed.
	return t < 0.0001 || t > 0.9999 
		? t 
		: (t < 0.5
			? +0.5 * pow(2.0, (20.0 * t) - 10.0)
			: -0.5 * pow(2.0, 10.0 - (20.0 * t)) + 1.0
		);
}

float indice(vec2 uv){
	float rayon = 0.01;
	float centre_x = exponentialInOut(abs(fract(TIME * speed) * 2.0 - 1.0));
	float centre_y = uv.y - f(uv);
	return (pow(rayon, 2.0) - pow(uv.x - centre_x, 2.0) 
		- pow(uv.y - (centre_y), 2.0)
	);
}

void fragment() {
	vec4 line_color = mix(color1, color2, UV.x);
	float draw_mix_value = smoothstep(line_width, line_smoothness, abs(f(UV)));
	vec4 tex1 = mix(bg_color, line_color, draw_mix_value);
	
	float indice_width = line_width / 10.0;
	float indice_smoothness = indice_width - 0.001;
	float mix_value = smoothstep(indice_width, indice_smoothness, abs( 
		indice(UV)
	));
	vec4 tex2 = mix(bg_color, indice_color, mix_value);
	
	COLOR = tex1 + tex2;
}
