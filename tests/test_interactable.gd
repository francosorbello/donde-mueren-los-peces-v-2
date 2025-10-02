extends Node2D


func _on_better_interactable_component_on_interact() -> void:
	GlobalSignal.level_change_requested.emit("level2")
