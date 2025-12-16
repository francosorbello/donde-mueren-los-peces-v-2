shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(0.0,0.0,0.0,0.6);
uniform sampler2D tex : repeat_enable, source_color;
uniform float pixelation = 32.0;
uniform vec2 scroll_speed;
//uniform vec4 border_color : source_color = vec4(0.0,0.0,0.0,0.0);
//uniform float border_width : hint_range(1,10,1) = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = UV;
	uv = floor(uv/SCREEN_PIXEL_SIZE / pixelation) * SCREEN_PIXEL_SIZE * pixelation;	
	
	vec4 col = texture(tex,uv + TIME * scroll_speed) * bg_color;
	COLOR = col;
}
