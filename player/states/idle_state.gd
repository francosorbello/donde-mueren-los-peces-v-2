extends PlayerState

func enter():
    player.play_anim("idle")

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("jump") and player.has_ability_named("jump"):
        state_machine.transition_to("JumpingState")

func physics_update(_delta: float):
    player.velocity = lerp(player.velocity,Vector2.ZERO, _delta * player.accel)
    player.move_and_slide()

    var direction = Input.get_vector("move_left","move_right","move_up","move_down")
    if direction:
        state_machine.transition_to("MovingState")
        return
