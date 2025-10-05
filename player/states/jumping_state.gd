extends PlayerState

@export var move_speed : float = 40
@export_range(1,25) var decay : float = 5

func enter():
    player.play_anim("idle")
    $JumpDurationTimer.start()
    play_show_bubble_anim()

func exit():
    $JumpDurationTimer.stop()
    play_hide_bubble_anim()

func play_bubble_anim(to_value : float) -> Tween:
    var sprite := player.get_bubble_sprite()
    var tween := create_tween()
    
    tween.tween_property(sprite,"scale",Vector2(to_value,to_value),0.3)
    
    return tween

func play_show_bubble_anim():
    player.get_bubble_sprite().visible = true
    player.get_bubble_sprite().scale = Vector2.ZERO
    play_bubble_anim(0.8)

func play_hide_bubble_anim():
    var tween := play_bubble_anim(0)
    tween.finished.connect(func():
        player.get_bubble_sprite().visible = false
    )

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("dash"):
        state_machine.transition_to("QuickDashingState")
        return

    if event.is_action_pressed("jump"):
        state_machine.transition_to("MovingState")
        get_viewport().set_input_as_handled()

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
