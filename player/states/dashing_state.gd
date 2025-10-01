extends PlayerState

@export var dash_speed_increment : float = 2
@export var accel : float = 100
@export var stop_treshold : float = 10
@export_group("Dash speed curve")
@export var min_speed_increment : float = 1
@export var max_speed_increment : float = 5
@export var speed_curve : Curve

var bubble : Node2D
var _direction
var _initial_dist : float

func _ready():
	speed_curve.min_domain = min_speed_increment
	speed_curve.max_domain = max_speed_increment

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
		_initial_dist = bubble.global_position.distance_to(player.global_position)-stop_treshold

func physics_update(delta: float):
	var dist : float = bubble.global_position.distance_to(player.global_position)

	player.velocity = FreyaMath.lerp_exp_decay(player.velocity,_direction * player.speed * get_speed_multiplier(dist),10,delta)
	player.move_and_slide()

	if  dist < stop_treshold:
		state_machine.transition_to("MovingState")
		return

func get_speed_multiplier(dist : float) -> float:
	if _initial_dist:
		var sample_point = 1 - (dist-stop_treshold)/_initial_dist
		return lerp(min_speed_increment,max_speed_increment,speed_curve.sample(sample_point))
	return 1
