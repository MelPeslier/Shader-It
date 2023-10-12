
// NOTE: Shader automatically converted from Godot Engine 4.1.1.stable's ProceduralSkyMaterial.

shader_type sky;
render_mode use_debanding;

uniform vec4 sky_top_color : source_color = vec4(0.385, 0.454, 0.55, 1.0);

uniform vec4 sky_horizon_color : source_color = vec4(0.646, 0.656, 0.67, 1.0);
uniform float sky_curve : hint_range(0, 1) = 0.15;
uniform float sky_energy = 1.0; // In Lux.
uniform sampler2D sky_cover : filter_linear, source_color, hint_default_black;
uniform vec4 sky_cover_modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 ground_bottom_color : source_color = vec4(0.2, 0.169, 0.133, 1.0);
uniform vec4 ground_horizon_color : source_color = vec4(0.646, 0.656, 0.67, 1.0);
uniform float ground_curve : hint_range(0, 1) = 0.02;
uniform float ground_energy = 1.0;
uniform float sun_angle_max = 30.0;
uniform float sun_curve : hint_range(0, 1) = 0.15;
uniform sampler2D moon_center_colors;
uniform sampler2D moon_noise;
uniform vec3 moon_edge_color : source_color;

void sky() {
	float v_angle = acos(clamp(EYEDIR.y, -1.0, 1.0));
	float c = (1.0 - v_angle / (PI * 0.5));
	vec3 sky = mix(sky_horizon_color.rgb, sky_top_color.rgb, clamp(1.0 - pow(1.0 - c, 1.0 / sky_curve), 0.0, 1.0));
	sky *= sky_energy;

			// Part to make the moon style
	if (LIGHT0_ENABLED) {
		float sun_angle = acos(dot(LIGHT0_DIRECTION, EYEDIR));
		if (sun_angle < LIGHT0_SIZE) {
			// Useful for simple circle pattern
//			vec2 uv = vec2( (sun_angle - LIGHT0_SIZE)/ LIGHT0_SIZE );
			float tex_noise = texture(moon_noise, SKY_COORDS).r;
			float energy = tex_noise;
			vec4 moon_tex = texture(moon_center_colors, vec2(energy) ) * LIGHT0_ENERGY;
			sky = moon_tex.rgb;
		} else if (sun_angle < sun_angle_max) {
			float c2 = (sun_angle - LIGHT0_SIZE) / (sun_angle_max - LIGHT0_SIZE);
			sky = mix(moon_edge_color * LIGHT0_ENERGY, sky, clamp(1.0 - pow(1.0 - c2, 1.0 / sun_curve), 0.0, 1.0));
		}
	}

	vec4 sky_cover_texture = texture(sky_cover, SKY_COORDS);
	sky += (sky_cover_texture.rgb * sky_cover_modulate.rgb) * sky_cover_texture.a * sky_cover_modulate.a * sky_energy;

	c = (v_angle - (PI * 0.5)) / (PI * 0.5);
	vec3 ground = mix(ground_horizon_color.rgb, ground_bottom_color.rgb, clamp(1.0 - pow(1.0 - c, 1.0 / ground_curve), 0.0, 1.0));
	ground *= ground_energy;

	COLOR = mix(ground, sky, step(0.0, EYEDIR.y));
}
