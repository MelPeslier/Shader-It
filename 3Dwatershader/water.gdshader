shader_type spatial;

uniform vec3 albedo : source_color = vec3(0, 82, 110);
uniform vec3 albedo_fresnel : source_color;
uniform float metallic : hint_range(0.04, 1.0) = 0.04;
uniform float roughness : hint_range(0.0, 1.0) = 0.02;
uniform sampler2D wave_vertex;
uniform sampler2D texture_normal;
uniform sampler2D texture_normal_2;
uniform vec2 wave_direction = vec2(2.0, 0.0);
uniform vec2 wave_direction_2 = vec2(0.0, 1.0);
// La vitesse de déplacement des vagues
uniform float time_scale : hint_range(0.0, 0.2, 0.005) = 0.025;
uniform float noise_scale_vertex = 10.0;
uniform float height_scale_vertex = 0.15;

// Pour l'effet de profondeur
uniform sampler2D depth_texture_base : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D screen_texture_base : hint_depth_texture, filter_linear_mipmap;
uniform vec4 color_deep : source_color;
uniform vec4 color_shallow : source_color;
uniform float beers_law = 2.0;
uniform float depth_offset = -0.75;

// Affichage en fonction de la position du monde pluto que de l'uvec
//    permet de rendre le mesh scalaire, et plus de problèmes d'échelle
// On utilise donc des varying variables qui permettent de convertir les valeurs
//    vertex shader à des valeurs pixel shader
varying float height;
varying vec3 world_position;

// Modifie la couleur de l'objet en fonction de point de vue de la caméra
//    par rapport au mesh
// Simule la relation entre l'angle d'une surface et la quantité de lumière
//    que l'on verra en emaner
float fresnel(float amount, vec3 normal, vec3 view){
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

// Définir les sommets de notre mesh (filet, maille)
void vertex(){
	// Mettre chacune des world_position des vertex de notre mesh
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	height = texture(wave_vertex, world_position.xz / noise_scale_vertex + TIME *
		time_scale).r;
	VERTEX.y += height * height_scale_vertex;
}

void fragment() {
	//Variables et calculs de la profondeur
	float depth_texture = texture(depth_texture_base, SCREEN_UV).r * 2.0 - 1.0;
	float depth = PROJECTION_MATRIX[3][2] / (depth_texture + PROJECTION_MATRIX[2][2]);
	float depth_blend = exp((depth+VERTEX.z + depth_offset) * -beers_law);
	depth_blend = clamp(1.0 - depth_blend, 0.0, 1.0);
	float depth_blend_power = clamp(pow(depth_blend, 2.5), 0.0, 1.0);
	
	vec3 screen_color = textureLod(screen_texture_base, SCREEN_UV, depth_blend_power * 2.5).rgb;
	vec3 depth_color = mix(color_shallow.rgb, color_deep.rgb, depth_blend_power);
	vec3 color = mix(screen_color * depth_color, depth_color * 0.25, depth_blend_power * 0.5);
	
	// Calcul du temps pour le mouvement des vagues
	vec2 time = (TIME * wave_direction) * time_scale;
	vec2 time_2 = (TIME * wave_direction_2) * time_scale;
	
	// Mix les 2 norml_map crées en 1 !
	vec3 normal_blend = mix(texture(texture_normal, world_position.xz + time).rgb,
		texture(texture_normal_2, world_position.xz + time_2).rgb, 0.5);
	
	// Calculer le Fresnel
	float fresnel = fresnel(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(albedo, albedo_fresnel, fresnel);
	
	// La couleur de base de l'objet
	ALBEDO = mix(surface_color, color, 0.75);
	// La réflection de l'objet
	METALLIC = metallic;
	// La façon dont la réfexion se produit
	ROUGHNESS = roughness;
	// Ajouter de la profondeur à l'objet sans modifier sa geometrie
	NORMAL_MAP = normal_blend;
}
