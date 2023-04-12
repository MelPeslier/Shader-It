shader_type canvas_item;

uniform float transparency : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float intensity : hint_range(0.0, 20.0, 0.1) = 3.0;

// pour choisir la couleur dans l'inspecteur, // vec4(1.0) pour blanc
uniform vec4 color : source_color = vec4(1.0);
uniform float red_intensity : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float green_intensity : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float blue_intensity : hint_range(0.0, 1.0, 0.1) = 1.0;

uniform float is_normal : hint_range(0.0, 1.0, 1.0) = 1.0;
uniform float is_gray : hint_range(0.0, 1.0, 1.0) = 0.0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 normal = vec4(
		pixelColor.r * red_intensity,
		pixelColor.g * green_intensity,
		pixelColor.b * blue_intensity,
		transparency);
	// on prend la couleur de chaque partie du modele RGB que l'on normalise
	float brightness = (
		pixelColor.r * red_intensity 
		+ pixelColor.g * green_intensity
		+ pixelColor.b * blue_intensity
		) / intensity;
	// On crée une échelle de gris 
	// texture.a pour la transparence
	float a = pixelColor.a * transparency;
	vec4 grayScale = vec4(brightness, brightness, brightness, a);
	
	//
	COLOR = (grayScale * is_gray + normal * is_normal) * color;
}
