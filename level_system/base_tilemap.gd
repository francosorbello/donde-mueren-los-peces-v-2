extends TileMapLayer

func _ready() -> void:
	var level_info = get_tree().get_first_node_in_group("level_info") as LevelInfo
	var palette_override = GlobalData.area_palettes[level_info.area_type]
	
	self.material.set_shader_parameter("output_palette_texture",palette_override)
