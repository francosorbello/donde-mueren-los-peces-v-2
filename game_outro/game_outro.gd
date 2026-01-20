extends Control

func _ready():
    $Menu.grab_focus()

func _on_menu_pressed() -> void:
    GlobalData.main_screen_manager.start_main_menu()
    pass # Replace with function body.

func _on_exit_pressed() -> void:
    get_tree().quit()

