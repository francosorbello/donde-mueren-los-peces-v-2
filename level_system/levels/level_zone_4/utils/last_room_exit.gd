extends Node2D

@export var game_outro_scene : PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is APlayer:
        body.disable_controls.call_deferred()
        exit_to_menu.call_deferred()

func exit_to_menu():
    # GlobalData.main_screen_manager.transition_to("GameOutro")
    var game_outro = game_outro_scene.instantiate()
    game_outro.modulate.a = 0
    get_tree().get_first_node_in_group("music").get_parent().add_child(game_outro)
    
    var tween := create_tween()
    tween.tween_property(game_outro,"modulate:a",1,1)
