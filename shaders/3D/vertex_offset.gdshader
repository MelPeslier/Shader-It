shader_type spatial;
render_mode unshaded;

uniform float time_speed : hint_range(0.0, 1.0) = 0.1;
uniform float wave_amplitude : hint_range(0.0, 1.0) = 0.1;
uniform bool erase_corners;


float get_radial_wave(vec2 uv){
	vec2 uvCentered = vec2(uv.x, 1.0 - uv.y) * 2.0 - 1.0;
	
	float radial_distance = length( uvCentered );
	
	float wave = cos( (radial_distance - TIME * time_speed) * TAU * 5.0 ) * 0.5 + 0.5;
	if (erase_corners){
		// If you don't add to the cos above by *0.5 + 0.5
		wave = wave < 0.0 ? 0.0 : wave;
	}
	wave *= 1.0 - radial_distance;
	return wave;
}

void vertex() {
	VERTEX.y = get_radial_wave(UV) * wave_amplitude;
}

void fragment() {
	ALBEDO =  vec3(get_radial_wave(UV));
}
