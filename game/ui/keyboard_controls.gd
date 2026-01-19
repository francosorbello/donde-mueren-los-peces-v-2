extends Control

func _ready() -> void:
    print("Hello keyboard controls")
    InputHelper.device_changed.connect(_on_input_device_changed)
    _on_input_device_changed(InputHelper.guess_device_name(),0)


func _on_input_device_changed(device : String, _index : int):
    print(device)
    if device == InputHelper.DEVICE_KEYBOARD:
        show()
    else:
        hide()