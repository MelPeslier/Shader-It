shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform sampler2D distortion_texture;

uniform float distortionScale : hint_range(-0.3, 0.3, 0.1) = 0.0;

void fragment() {
	vec2 distortedUV = SCREEN_UV + texture(distortion_texture, UV).r * 0.05;
	distortedUV.x += distortedUV.y * distortionScale;
	vec4 screen_color = texture(screen_texture, distortedUV);
	
	COLOR = screen_color;
}
