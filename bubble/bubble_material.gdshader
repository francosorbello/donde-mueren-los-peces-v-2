shader_type canvas_item;

uniform vec4 color : source_color;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(TEXTURE,UV);
	vec4 world_col = texture(SCREEN_TEXTURE,SCREEN_UV);
	COLOR.rgb = world_col.rgb * (col.rgb*col.rgb);
	//COLOR = world_col * col;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
