extends PlayerState


func enter():
    player.play_anim("move")


func physics_update(delta: float):
    var direction = Input.get_vector("move_left","move_right","move_up","move_down")

    player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.move_and_slide()

    if direction == Vector2.ZERO:
        state_machine.transition_to("IdleState")
        return
    else:
        player.last_direction = direction