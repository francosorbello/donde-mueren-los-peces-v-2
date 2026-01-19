extends HBoxContainer

@export var disabled_color : Color
@export var dash_ability : AnItem

var has_dash : bool = false

func _ready():
	var save = SaveUtils.get_save()
	if save:
		save.ability_added.connect(_on_ability_added)
		if save.unlocked_abilities.has(dash_ability):
			show_dash()
	
	GlobalSignal.jump_started.connect(enable_dash)
	GlobalSignal.jump_finished.connect(disable_dash)
	GlobalSignal.dash_started.connect(disable_dash)

func _on_ability_added(ability : AnItem):
	if ability == dash_ability:
		show_dash()

func enable_dash():
	if not has_dash:
		return
	$Label.modulate = Color.WHITE
	$TextureRect.modulate = Color.WHITE

func show_dash():
	$Label.text = tr("UI_DASH")
	has_dash = true
	disable_dash()


func disable_dash():
	if not has_dash:
		return

	$TextureRect.modulate = disabled_color
	$Label.modulate = disabled_color
