extends PlayerState

@export var bubble_indicator : Path2D
var shoot_direction : Vector2

var _bubble_shot : bool = false

func enter():
	_bubble_shot = false
	player.velocity = Vector2.ZERO
	player.play_anim("idle")
	player.soften_sprite(true)
	bubble_indicator.show()

func exit():
	player.soften_sprite(false)
	bubble_indicator.hide()

func state_unhandled_input(event : InputEvent):
	if event.is_action_released("shoot_bubble"):
		if player.bubble_manager:
			player.bubble_manager.shoot_bubble(player.global_position,shoot_direction)
			_bubble_shot = true
			await get_tree().create_timer(.1).timeout

		state_machine.transition_to("IdleState")
		return

func physics_update(_delta: float):
	if _bubble_shot: return
	
	var selected_dir = Input.get_vector("move_left","move_right","move_up","move_down")
	if selected_dir != Vector2.ZERO:
		shoot_direction = selected_dir
		bubble_indicator.set_direction(selected_dir)
