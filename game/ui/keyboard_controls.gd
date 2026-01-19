extends Control

@export var jump_ability : AnItem
@export var dash_ability : AnItem

func _ready() -> void:
    InputHelper.device_changed.connect(_on_input_device_changed)
    _on_input_device_changed(InputHelper.guess_device_name(),0)
    var save = SaveUtils.get_save()
    if save:
        save.ability_added.connect(handle_new_ability)
        for ab in save.unlocked_abilities:
            handle_new_ability(ab)

func handle_new_ability(_ab : AnItem):
    if _ab == jump_ability:
        $VBoxContainer/JumpContainer.show()
        $VBoxContainer/HSeparator.show()
    if _ab == dash_ability:
        $VBoxContainer/DashContainer.show()
        $VBoxContainer/HSeparator.show()


func _on_input_device_changed(device : String, _index : int):
    if device == InputHelper.DEVICE_KEYBOARD:
        show()
    else:
        hide()