shader_type canvas_item;

uniform vec4 bgcolor : source_color;
uniform float height : hint_range(0.01, 0.45, 0.01) = 0.1;
uniform float width : hint_range(0.01, 0.45, 0.01) = 0.1;

void fragment() {
	float bottom = step(width, 1.0 - UV.y);
	float top = step(width, UV.y);
	
	float right = step(height, 1.0 - UV.x);
	float left = step(height, UV.x);
	
	float pct = right * left * top * bottom;
	
	COLOR.rgb = vec3(pct);
	COLOR.a = 1.0;
}
