shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	c = vec3(1.0) - c;
	
	vec4 color = vec4(c, 1.0);
	
	COLOR.rgba = color;
}