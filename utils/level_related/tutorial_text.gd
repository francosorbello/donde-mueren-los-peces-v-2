extends RichTextLabel

@export var action_gamepad : String
@export_file_path() var keyboard_path : String

var _initial_text : String

func _ready() -> void:
    assert(not action_gamepad.is_empty(), "No action gamepad on tutorial text %s"%name)
    assert(not keyboard_path.is_empty(), "No keyboard path on tutorial text %s"%name)

    _initial_text = text
    InputHelper.device_changed.connect(_on_input_device_changed)
    
    _on_input_device_changed(InputHelper.guess_device_name(),0)

func _on_input_device_changed(device : String, _index : int):
    if device == InputHelper.DEVICE_KEYBOARD:
        set_text_with_texture(keyboard_path)
    else:
        var path : String = ""
        if InputUtils.is_playstation_gamepad(device):
            path = get_gamepad_path("ps")
        else:
            path = get_gamepad_path("xbox")
        set_text_with_texture(path)

func set_text_with_texture(path_to_tex : String):
    var new_text = _initial_text
    new_text = new_text.replace("{input}","[img]%s[/img]"%path_to_tex)

    text = new_text


func get_gamepad_path(device : String) -> String:
    return "res://assets/GRAPHICS/inputs/%s/%s.png"%[device,action_gamepad]