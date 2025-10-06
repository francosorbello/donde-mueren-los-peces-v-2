shader_type canvas_item;
uniform sampler2D tile_tex : repeat_enable, filter_nearest;

uniform vec4 color_to_replace : source_color;
uniform vec4 color_replacement : source_color;

uniform vec2 motion = vec2(0.0);
uniform float scale = 1.0;
uniform vec2 offset = vec2(0.0);

void vertex() {
	UV = (VERTEX + offset + TIME * motion) * TEXTURE_PIXEL_SIZE * (1.0/scale);
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(tile_tex,UV);
	if (length(col-color_to_replace) < 0.1){
		col = color_replacement;
	}
	COLOR = col;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
