extends Sprite2D


func _on_better_interactable_component_on_interact() -> void:
    $BetterInteractableComponent.set_deferred("is_interactable",false)
    var game = get_tree().get_first_node_in_group("inventory_manager").get_parent()
    var tween = game._fade_to_player(0.0)
    tween.finished.connect(func():
        GlobalSignal.on_request_main_scene_change.emit("EndDemo")
    )
    
