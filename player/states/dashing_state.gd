extends PlayerState

@export var dash_speed_increment : float = 2
@export var accel : float = 100
@export var stop_treshold : float = 10

var bubble : Node2D
var _direction

func enter():
	if not bubble:
		push_error("No bubble available for dash")
		state_machine.transition_to("MovingState")
		return

func exit():
	bubble.clear_as_dash_target()
	bubble = null

func receive_message(message : Dictionary):
	if message.has("bubble"):
		bubble = message["bubble"]
		bubble.set_as_dash_target()
		_direction = (bubble.global_position - player.global_position).normalized()

func physics_update(delta: float):
	player.velocity = lerp(player.velocity,_direction * player.speed * dash_speed_increment, delta * accel)
	player.move_and_slide()

	if bubble.global_position.distance_to(player.global_position) < stop_treshold:
		state_machine.transition_to("MovingState")
		return
