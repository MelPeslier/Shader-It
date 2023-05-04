shader_type canvas_item;

uniform sampler2D bg_color : source_color;
uniform sampler2D line_color : source_color;
uniform float size : hint_range(0.0, 1.0) = 0.02;
uniform float smoothness : hint_range(0.0, 1.0) = 0.0;

float my_mix(vec2 tex_uv){
	return smoothstep(size, smoothness, abs(tex_uv.y - tex_uv.x));
}

void fragment() {
	float mix_value = my_mix(UV);
	vec4 bg_tex = texture(bg_color,UV);
	vec4 line_tex = texture(line_color,UV);
	
	/* Ces deux lignes de codes effectues une interpolation linéaire
	 Elles reviennent à */
	//vec4 final_color = (1.0 - line_pos) * bg_tex + line_pos * line_tex;
	vec4 final_color = mix(bg_tex, line_tex, mix_value);
	
	COLOR = final_color;
}
