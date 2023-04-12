//On définit le type de shader : provenant de convas_item
shader_type canvas_item;
// uniform permet d'y avoir accès dans la console
//hint_range pour une portée de modification possible
uniform float scale : hint_range(0.5, 2.0, 0.1) = 1.0;

//La fonction fragment() permet d'écrire pour chaque pixels de notre image
void fragment() {
	//On définit un vecteur 4 pour RGB et la Transparence
	//TEXTURE permet d'accéder à la texture de l'image
	//UV permet d'accéder à la coordonnée du pixel
	vec4 pixelColor = texture(TEXTURE, UV * scale);
	
	//COLOR permet d'écrire la nuance de couleur des pixels
	COLOR = pixelColor;
}
