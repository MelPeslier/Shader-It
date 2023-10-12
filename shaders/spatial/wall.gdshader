shader_type spatial;

uniform vec4 albedo : source_color;

void fragment() {
	ALBEDO = albedo.rgb;
}
