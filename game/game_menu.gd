extends Control

@export var music : AudioStreamPlayer

var _original_volume : float
var on_dialogue : bool = false

func _ready():
    if music:
        _original_volume = music.volume_linear
    
    DialogueManager.dialogue_started.connect(func(_d):
        if visible:
            toggle_ui()
            on_dialogue = true
    )    

    DialogueManager.dialogue_ended.connect(func(_d):
        on_dialogue = false
    )

    visibility_changed.connect(func():
        if visible:
            $PanelContainer/VBoxContainer/ContinueBtn.grab_focus()
    )

    $SettingsMenu.visibility_changed.connect(func():
        if not $SettingsMenu.visible:
            $PanelContainer/VBoxContainer/OptionsMenu.grab_focus()
    )

func _unhandled_input(event: InputEvent) -> void:

    if (event.is_action_pressed("pause") and not on_dialogue) or (visible and event.is_action_pressed("ui_cancel")):
        toggle_ui()

    if visible:
        get_viewport().set_input_as_handled()

func toggle_ui():
    visible = not visible
    GlobalSignal.game_pause_toggled.emit(visible)
    if music:
        var new_volume = _original_volume
        if visible:
            new_volume -= 0.3
        anim_music_volume(new_volume)

func _on_continue_btn_pressed() -> void:
    toggle_ui()

func _on_exit_button_pressed() -> void:
    get_tree().quit()
    pass # Replace with function body.

func anim_music_volume(to_value : float):
    var tween := create_tween()
    tween.tween_property(music,"volume_db",linear_to_db(to_value),0.5).from(linear_to_db(_original_volume))

func _on_options_menu_pressed() -> void:
    $SettingsMenu.show()
    pass # Replace with function body.
