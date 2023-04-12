shader_type canvas_item;

uniform float distord : hint_range(-5.0, 5.0, 0.1) = 0.0;

void fragment() {
	// On crée une variable à partir de UV pour y appliquer les modiications que l'on veut
	vec2 distortionUV = UV;
	distortionUV.x += distortionUV.y * distord;
	
	vec4 pixelColor = texture(TEXTURE, distortionUV * 1.0);
	COLOR = pixelColor;
}
