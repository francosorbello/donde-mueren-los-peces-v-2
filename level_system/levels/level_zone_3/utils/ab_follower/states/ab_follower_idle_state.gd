extends State

func enter():
	state_owner.get_animation_player().play("idle")

func can_exit() -> bool:
	return state_owner.target != null

func update(_delta: float):
	if state_owner.target:
		if state_owner.target.global_position.distance_to(state_owner.global_position) > state_owner.stop_treshold:
			state_machine.transition_to("MovingState")
