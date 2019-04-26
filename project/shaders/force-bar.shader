shader_type canvas_item;

uniform sampler2D sprite_mask : hint_albedo;
uniform float cut_off = 0.5;

void fragment() {
	float mask = texture(sprite_mask, UV).r;
	if (mask <= cut_off) {
		discard;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}