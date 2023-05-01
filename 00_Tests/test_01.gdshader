shader_type particles;

float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0)
	s = 305420679;
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0)
		s += 2147483647;
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}

void start() {
	uint seed = RANDOM_SEED + NUMBER;
	vec3 direction = vec3(rand_from_seed(seed) - 0.5, rand_from_seed(seed) - 0.5, 0);
	float speed = rand_from_seed(seed) * 1000.0;
	TRANSFORM[3].xy = vec2(0.0, 0.0);
	VELOCITY = direction * speed;
	COLOR.a = 1.0;
}

void process() {
	VELOCITY.y -= 25.0;
	
	COLOR.a = max(COLOR.a - DELTA, 0.0);
}

