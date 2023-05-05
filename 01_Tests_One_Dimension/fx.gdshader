shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(vec3(0.0), 1.0);
uniform vec4 line_color : source_color = vec4(vec3(1.0), 1.0);
uniform float size : hint_range(0.0, 1.0) = 0.04;
uniform float smoothness : hint_range(0.0, 1.0) = 0.039;
uniform float taille_graph : hint_range(0.5, 20.0) = 10.0;
uniform float puissance : hint_range(0.01, 10.0) = 3.0;
uniform float speed : hint_range(0.0, 1.0) = 1.0;

float f_sinus(vec2 tex_uv){
	return smoothstep(size, smoothness, abs(sin(-tex_uv.x * puissance + TIME * speed) - tex_uv.y));
}

float f_cosinus(vec2 tex_uv){
	return smoothstep(size, smoothness, abs(cos(-tex_uv.x * puissance + TIME * speed) - tex_uv.y));
}

void fragment() {
	float mix_value_cos = f_cosinus(taille_graph / 2.0 - UV * taille_graph);
	vec4 cosinus = mix(bg_color, line_color, mix_value_cos);
	
	float mix_value_sin = f_sinus(taille_graph / 2.0 - UV * taille_graph);
	vec4 sinus = mix(bg_color, line_color, mix_value_sin);
	
	COLOR = cosinus + sinus;
}
