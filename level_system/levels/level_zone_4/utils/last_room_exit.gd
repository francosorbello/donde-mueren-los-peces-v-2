extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is APlayer:
        body.disable_controls.call_deferred()
        exit_to_menu.call_deferred()

func exit_to_menu():
    GlobalData.main_screen_manager.start_main_menu()
