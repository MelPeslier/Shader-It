shader_type canvas_item;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	
	// On peut inverser les couleurs
	// COLOR.rgb = COLOR.bgr;
	
	// On peut par exemple mettre le rouge en echelle de gris et jeter le reste !
	// COLOR.rgb = COLOR.rrr;
	
	COLOR.rgb = COLOR.brb;
}
