shader_type canvas_item;

uniform sampler2D bg_color : source_color;
uniform vec4 line_color : source_color = vec4(vec3(0.0), 1.0);
uniform float size : hint_range(0.0, 1.0) = 0.02;
uniform float smoothness : hint_range(0.0, 1.0) = 0.0;
uniform float puissance : hint_range(0.01, 10.0) = 1.0;

float my_mix(vec2 tex_uv){
	return smoothstep(size, smoothness, abs(pow(tex_uv.y, puissance) - tex_uv.x));
}

void fragment() {
	float mix_value = my_mix(UV);
	
	vec4 bg_tex = texture(bg_color, UV);
	COLOR = mix(bg_tex, line_color, mix_value);
}
