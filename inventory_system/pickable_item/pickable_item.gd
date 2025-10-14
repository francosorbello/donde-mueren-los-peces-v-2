@tool
extends Node2D

var icon : Texture2D:
	set(value):
		icon = value
		if Engine.is_editor_hint():
			$FloatingSprite.texture = value

@export var item : AnItem:
	set(value):
		item = value
		if Engine.is_editor_hint():
			if item:
				icon = item.world_icon
			else:
				icon = null

func _on_better_interactable_component_on_interact() -> void:
	var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
	if inventory_manager and item:
		inventory_manager.add_item(item)
	
	queue_free()
