shader_type canvas_item;

uniform float x_scale : hint_range(-10.0, 10.0, 0.1);
uniform float y_scale : hint_range(-10.0, 10.0, 0.1);
uniform float x_speed : hint_range(-10.0, 10.0, 0.1);
uniform sampler2D noise;
uniform vec4 tex_color : source_color;

void vertex() {
	vec2 distorted_uv = UV;
	distorted_uv.y = sin(distorted_uv.x + TIME * x_speed) + distorted_uv.x;
	VERTEX = vec2(VERTEX.x * x_scale , VERTEX.y * y_scale) * distorted_uv;
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 tex_1 = tex * tex_color;
	COLOR = tex_1;
}
