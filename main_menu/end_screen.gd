extends Control

func _ready() -> void:
    $HBoxContainer/VSFormLink.grab_focus()

func _on_vs_form_link_pressed() -> void:
    OS.shell_open("https://forms.gle/iVP31QSC2iQQtKjLA")


func _on_exit_button_pressed() -> void:
    get_tree().quit()
