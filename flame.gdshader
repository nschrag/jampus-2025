shader_type canvas_item;

uniform vec2 res = vec2(256, 256);
uniform vec3 upper_color: source_color = vec3(1.0, 0.5, 0.0);
uniform vec3 color_2: source_color = vec3(1.0, 0.5, 0.0);
uniform float width: hint_range(0.01, 1.0, 0.01) = 2.0;
uniform float curve: hint_range(0.1, 10.0, 0.01) = 2.0;

void fragment() {
	vec2 uv = vec2(UV.x - 0.5, UV.y);
	/*
	uv.x *= res.x / res.y;
	//float w = width * 0.1;
	vec3 top = vec3(0.0);
	float flame = pow(abs(uv.x), curve) / width;
	float shape = abs(uv.y / 16.0 - flame);
	top = smoothstep(0.0, 1.0, 1.0 - shape) * upper_color;
	top = (1.0 - shape) * upper_color;
	vec3 final_color = mix(color_2, upper_color, .6 + abs(uv.x));
	COLOR = vec4(final_color, 1.0 - (shape * 4.0));
	float a = 1.0 - min(1.0 - (flame * 4.0), 1.0 - ((uv.y)));
	//a = 1.0 - ((uv.y));
	COLOR = vec4(final_color, a);
	//COLOR = vec4(top, 1.0);
	//------------------
	*/
	float a1 = step(0.4, abs(uv.x) + pow(1.0 - UV.y, 3.0));
	float a_prime = abs(uv.x) * 3.0 + pow(1.0 - UV.y, 2.0);
	float a2 = smoothstep(0.4, 0.9, a_prime);
	float blend = smoothstep(0.4, 0.6, a_prime);
	vec3 final_color = mix(upper_color, color_2, blend);
	COLOR = vec4(upper_color, min(a1, a2));
	COLOR = vec4(final_color, (1.0 - a2) * 0.9);
}
