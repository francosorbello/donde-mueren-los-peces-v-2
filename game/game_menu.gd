extends Control

@export var music : AudioStreamPlayer

var _original_volume : float

func _ready():
    if music:
        _original_volume = music.volume_db

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        toggle_ui()

func toggle_ui():
    visible = not visible
    if music:
        var new_volume = _original_volume if visible else (_original_volume - 30)
        anim_music_volume(new_volume)

func _on_continue_btn_pressed() -> void:
    hide()

func _on_exit_button_pressed() -> void:
    get_tree().quit()
    pass # Replace with function body.

func anim_music_volume(to_value : float):
    var tween := create_tween()
    tween.tween_property(music,"volume_db",to_value,0.5)