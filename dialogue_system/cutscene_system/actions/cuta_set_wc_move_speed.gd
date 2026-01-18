extends CutsceneAction

@export var wc_target : Node2D
@export var move_speed : float
@export var step_volume : float = -10

func do_action():
	assert(wc_target)
	var move_component = wc_target.get_node_or_null("WCMoveComponent")
	assert(move_component)
	assert("speed" in move_component)

	move_component.speed = move_speed

	var step_sounds = wc_target.get_node_or_null("StepSounds")
	assert(step_sounds)
	step_sounds.volume_db = step_volume
