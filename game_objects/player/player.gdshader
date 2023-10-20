shader_type canvas_item;

uniform float emission_power: hint_range(0.0, 16.0, 0.1) = 1.0;
uniform vec3 color: source_color = vec3(1.0); 

void fragment() {
	COLOR = texture(TEXTURE, UV).rgba * vec4(color,1.0) * emission_power;
}
