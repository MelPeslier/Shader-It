shader_type spatial;
render_mode unshaded;

uniform sampler2D main_texture;
uniform sampler2D pattern_texture;
uniform vec2 uv1_scale;
uniform vec2 uv1_offset;
varying vec4 world_pos;
uniform float time_speed : hint_range(0.0, 1.0) = 0.1;

float get_radial_wave(float coord){
	float wave = cos( (coord - TIME * time_speed) * TAU * 5.0 ) * 0.5 + 0.5;
	wave *= coord;
	return wave;
}

void vertex() {
//	UV = UV * uv1_scale + uv1_offset;
	// World space coordiantes
	world_pos = MODEL_MATRIX * vec4( VERTEX, 1.0); 
}

void fragment() {
	// World space coordiantes : no need to scale or give offset, it's done in world space
	vec2 top_down_projection = world_pos.xz;
	vec4 ground = texture( main_texture, top_down_projection );
	vec4 pattern = texture( pattern_texture, UV);
	float pat = pattern.x;

//	ALBEDO = vec3( get_radial_wave( pat ) );

	vec4 final_tex = mix( vec4(1.0, 0.0, 0.0, 1.0), ground, pat );
	ALBEDO = final_tex.rgb;
//	ALBEDO = ground.rgb;
	
}
