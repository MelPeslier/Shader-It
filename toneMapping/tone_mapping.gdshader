shader_type canvas_item;

uniform sampler2D gradient;

uniform float scale : hint_range(0.5, 5.0, 0.1) = 1.0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	float brigthness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	vec4 gradientColor = texture(gradient, vec2(brigthness)) * scale;
	
	COLOR.a = gradientColor.b;
}
