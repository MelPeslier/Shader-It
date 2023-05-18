shader_type canvas_item;

uniform vec4 bgcolor : source_color;
uniform float height : hint_range(0.01, 0.45, 0.01) = 0.1;
uniform float width : hint_range(0.01, 0.45, 0.01) = 0.1;
uniform float blur : hint_range(0.01, 0.46, 0.01) = 0.101;

float square_it(float x, float y){
	float bottom = smoothstep(width, blur > width ? blur : width, 1.0 - y);
	float top = smoothstep(width, blur > width ? blur : width, y);
	
	float right = smoothstep(height, blur > height ? blur : height, 1.0 - x);
	float left = smoothstep(height, blur > height ? blur : height, x);
	
	return bottom * top * right * left;
}

void fragment() {

	
	float pct = square_it(UV.x, UV.y);
	
	COLOR.rgb = vec3(pct);
	COLOR.a = 1.0;
}
