extends Sprite2D


func _on_better_interactable_component_on_interact() -> void:
    $BetterInteractableComponent.set_deferred("is_interactable",false)
    GlobalData.main_screen_manager.transition_to("EndDemo")