shader_type canvas_item;

uniform sampler2D dissolve_texture: hint_default_white;
uniform float dissolve_value: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float emission_power: hint_range(0.0, 16.0, 0.01) = 1.0;
uniform vec3 color: source_color = vec3(1.0); 

float dissolve(vec2 uv) {
	vec4 noise_texture = texture(dissolve_texture, uv);
    return floor(dissolve_value + min(1, noise_texture.x));
}

void fragment() {
	COLOR = texture(TEXTURE, UV).rgba * vec4(color * emission_power,1.0) * dissolve(UV);
}
