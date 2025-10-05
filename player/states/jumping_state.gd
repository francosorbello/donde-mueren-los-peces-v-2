extends PlayerState

@export var move_speed : float = 40
@export_range(1,25) var decay : float = 5

func enter():
    $JumpDurationTimer.start()
    player.play_anim("bubble_up")

func exit():
    $JumpDurationTimer.stop()
    player.play_anim("bubble_down")

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("dash"):
        state_machine.transition_to("QuickDashingState")
        return

    # if event.is_action_released("jump"):
    #     state_machine.transition_to("MovingState")

func physics_update(delta: float):
    var direction = Input.get_vector("move_left","move_right","move_up","move_down")

    # player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,direction * move_speed, decay, delta)
    player.move_and_slide()

    if direction != Vector2.ZERO:
        player.last_direction = direction

func _on_jump_duration_timer_timeout() -> void:
    state_machine.transition_to("MovingState")
    pass # Replace with function body.
