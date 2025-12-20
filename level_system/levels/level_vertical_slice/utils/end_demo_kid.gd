extends Sprite2D


func _on_better_interactable_component_on_interact() -> void:
    GlobalSignal.on_request_main_scene_change.emit("EndDemo")
    pass # Replace with function body.
