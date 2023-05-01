shader_type canvas_item;

uniform sampler2D lifeTimeGradient;
uniform sampler2D toneMapping;

void fragment() {
	float particleLife = COLOR.r;
	vec4 baseColor = texture(TEXTURE, UV);
	baseColor *= texture(toneMapping, baseColor.rr);
	float appearenceState = particleLife * 2.0 - UV.x * 0.5 ;
	if (appearenceState > 0.0) {
		COLOR = texture(lifeTimeGradient, vec2(appearenceState)) * baseColor;
	}
	else {
		COLOR.a = 0.0;
	}
}
