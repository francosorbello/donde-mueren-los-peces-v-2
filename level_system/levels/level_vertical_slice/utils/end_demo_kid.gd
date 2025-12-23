extends Sprite2D


func _on_better_interactable_component_on_interact() -> void:
    $BetterInteractableComponent.set_deferred("is_interactable",false)
    var game = get_tree().get_first_node_in_group("inventory_manager").get_parent()
    var tween = game._fade_to_player(0.0)
    tween.finished.connect(func():
        GlobalData.main_screen_manager.transition_to("EndDemo")
    )
    
