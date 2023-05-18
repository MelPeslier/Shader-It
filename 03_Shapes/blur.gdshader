shader_type canvas_item;

uniform vec4 bgcolor : source_color;
uniform float height : hint_range(0.01, 0.45, 0.01) = 0.1;
uniform float blur_height : hint_range(0.01, 0.46, 0.01) = 0.101;
uniform float width : hint_range(0.01, 0.45, 0.01) = 0.1;
uniform float blur_width : hint_range(0.01, 0.46, 0.01) = 0.101;

void fragment() {
	float bottom = smoothstep(width, blur_width, 1.0 - UV.y);
	float top = smoothstep(width, blur_width, UV.y);
	
	float right = smoothstep(height, blur_height, 1.0 - UV.x);
	float left = smoothstep(height, blur_height, UV.x);
	
	float pct = right * left * top * bottom;
	
	COLOR.rgb = vec3(pct);
	COLOR.a = 1.0;
}
