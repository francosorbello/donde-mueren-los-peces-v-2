extends PlayerState

var path_to_follow : PathFollow2D
@export var speed : float = 20
@export var horizontal_speed : float = 20
func enter():
	player.play_anim("idle")
	player.velocity = Vector2.ZERO

func exit():
	path_to_follow = null

func receive_message(message : Dictionary):
	if message.has("path_to_follow"):
		path_to_follow = message["path_to_follow"]
		path_to_follow.progress_ratio = 0
		path_to_follow.h_offset = 0


func physics_update(delta: float):
	if not path_to_follow: 
		return
	var dir_x = Input.get_axis("move_left","move_right")

	path_to_follow.progress += delta * speed
	path_to_follow.h_offset += dir_x
	# var n_pos = path_to_follow.global_position + Vector2(dir_x,0) * horizontal_speed
	
	player.global_position = FreyaMath.lerp_exp_decay(player.global_position,path_to_follow.global_position,5,delta)
	if path_to_follow.progress_ratio > 0.9:
		state_machine.transition_to("MovingState")
		return
