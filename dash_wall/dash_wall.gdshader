shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(0.0,0.0,0.0,0.6);
//uniform vec4 border_color : source_color = vec4(0.0,0.0,0.0,0.0);
//uniform float border_width : hint_range(1,10,1) = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = bg_color;
}
