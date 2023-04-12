shader_type canvas_item;

uniform vec4 flashColor : source_color = vec4(1.0);
uniform float flashState : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	// Interpolation lineaire, soit changement d'etat, de a vers b, par c
	// mix(a, b, c);
	
	// Ici on passe de la couleur normale des pixels
	// A la couleur du flash voulue,
	// Par une valeur flotante entre 0.0 et 1.0
	
	// Un peu comme si on dessinait une image de la couleur "flashColor"
	// Par dessus "pixelColor" 
	// (en vrai ça transforme la couleur des pixels meme de l'image
	// Avec une transparence de "flashState".
	COLOR = mix(pixelColor, flashColor, flashState);
	
	// Pourconserver la transparence
	COLOR.a *= pixelColor.a;
}
