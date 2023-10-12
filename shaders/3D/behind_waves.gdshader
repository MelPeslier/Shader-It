shader_type spatial;
//Depth test disabmed is here so we can see the mesh even behind any parents
render_mode blend_add, cull_disabled, depth_test_disabled, shadows_disabled, unshaded;
// Shadows disabled mean that no other object can cast a shadow on it
// Unshaded : full color, no light alter it

uniform float time_speed : hint_range(0.0, 1.0) = 1.0;
uniform vec4 albedo_start : source_color;
uniform vec4 albedo_end : source_color;

uniform sampler2D depth_tex : hint_depth_texture;

// for passing the local NORMAL from the vertex to the fragment
varying vec3 norm;


void vertex() {
// NORMAL in vertex is the normal of the local transform
	norm = NORMAL;
}


void fragment() {
//	Afin d'afficher notre objet seulement si il est derrière un autre
//	On récupère la profondeur de notre objet
//	Puis on voit si notre profondeur est supérieur ou inférieure à la profondeur de notre caméra
//	depth < 0 : notre objet n'est pas au premier plan
//	sinon il l'est
	float depth = texture(depth_tex, SCREEN_UV).r;
	depth = PROJECTION_MATRIX[3][2] / ( depth + PROJECTION_MATRIX[2][2] );
	depth = VERTEX.z + depth;
	
	if (depth >= 0.0){
//		Afin de visualiser si un objet doit être dessiner ou non
		discard;
	} else{
		float time = TIME * time_speed;
		float x_offset = cos( (UV.x) * TAU * 8.0) * 0.01;
		float t = cos( ( UV.y + x_offset + time) * TAU * 8.0 ) * 0.5 + 0.5;
		
		float top_to_bottom = UV.y;
		float bottom_to_top = 1.0 - UV.y;
		
		t *= top_to_bottom;
		
//		Pour ne pas afficher la face qui pointe vers le haut ou le bas : z et -z
		float topBottomRemover = ( abs(norm.y) < 0.999 ? 1.0 : 0.0);
		float waves = t * topBottomRemover;
		
//		ALBEDO = vec3(waves);
		vec4 gradient = mix(albedo_start, albedo_end, bottom_to_top);
		ALBEDO = gradient.rgb * waves;
	}
}
