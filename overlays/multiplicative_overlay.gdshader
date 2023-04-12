shader_type canvas_item;

uniform sampler2D gradient;

uniform float scale : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 gradientColor = texture(gradient, UV);
	
	COLOR = mix(pixelColor, gradientColor, scale);
}
