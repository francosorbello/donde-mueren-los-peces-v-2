shader_type canvas_item;

uniform vec4 modulate_color : source_color;
uniform float scroll_speed = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(TEXTURE,vec2(UV.x,UV.y + TIME * scroll_speed * 0.1));
	//COLOR = color * modulate_color;
	//COLOR = vec4(SCREEN_UV,1.0,1.0);
	COLOR = color * modulate_color;
	COLOR.a = mix(0.0,COLOR.a,UV.y-0.3);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
