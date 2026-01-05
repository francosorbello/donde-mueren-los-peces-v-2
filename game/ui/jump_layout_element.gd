extends HBoxContainer

@export var jump_ability : AnItem

func _ready():
    var save = SaveUtils.get_save()
    if save:
        save.ability_added.connect(_on_ability_added)
        if save.unlocked_abilities.has(jump_ability):
            enable()

    GlobalSignal.jump_started.connect(func():
        $Label.text = tr("UI_CANCEL_JUMP")
    )
    GlobalSignal.jump_finished.connect(func():
        $Label.text = tr("UI_JUMP")
    )

func _on_ability_added(ability : AnItem):
    if ability == jump_ability:
        enable()

func enable():
    $Label.text = tr("UI_JUMP")
    $Label.modulate = Color.WHITE
    $TextureRect.modulate = Color.WHITE

