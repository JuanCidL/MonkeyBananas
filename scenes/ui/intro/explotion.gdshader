shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	vec4 color = vec4(c, 1.0);
	
	vec2 uv = UV - 0.125;
	float r = 0.125;
	float d = length(uv);
	
	if (d>r)
		color = vec4(0.0);
	
	COLOR.rgba = color;
}