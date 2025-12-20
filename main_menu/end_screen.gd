extends Control

func _on_vs_form_link_pressed() -> void:
    OS.shell_open("https://forms.gle/6x8WEMiHSarHGpVAA")


func _on_exit_button_pressed() -> void:
    get_tree().quit()
