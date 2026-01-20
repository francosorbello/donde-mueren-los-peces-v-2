extends Control

func _unhandled_input(_event: InputEvent) -> void:
    get_viewport().set_input_as_handled()

func _ready():
    $Menu.grab_focus()

func _on_menu_pressed() -> void:
    GlobalData.main_screen_manager.start_main_menu()
    pass # Replace with function body.

func _on_exit_pressed() -> void:
    get_tree().quit()

