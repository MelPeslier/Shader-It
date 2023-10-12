shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

void vertex() {
	VERTEX = VERTEX * vec2(1.0, 2.0);
}

void fragment() {
	vec4 tex = texture(screen_texture ,UV);
	tex.r = tex.r * 2.0;
	tex.b = tex.b * 0.2;
	tex.g = tex.g * 0.7;
	COLOR = tex * 0.1;
}
