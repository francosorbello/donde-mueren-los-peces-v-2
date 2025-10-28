extends PlayerState


func enter():
    player.play_anim("move")

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("jump") and player.has_ability_named("jump"):
        state_machine.transition_to("JumpingState")

func physics_update(delta: float):
    var direction = Input.get_vector("move_left","move_right","move_up","move_down")

    # player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,direction * player.speed, 10, delta * player.accel)
    player.move_and_slide()

    if direction == Vector2.ZERO:
        state_machine.transition_to("IdleState")
        return
    else:
        player.last_direction = direction