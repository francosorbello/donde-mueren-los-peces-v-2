extends PlayerState

@export var move_speed : float = 40
@export_range(1,25) var decay : float = 5

@export_group("Dependencies")
@export var death_zone_hurtbox : Area2D

@export_group("Jump speed curve")
@export var sample_duration : float = 3
@export var speed_curve : Curve

var _accoumulated_sample_time : float = 0
var _keep_hurtbox_disabled : bool = false

func enter():
    death_zone_hurtbox.toggle_active(false)

    _accoumulated_sample_time = 0
    _keep_hurtbox_disabled = false
    $JumpDurationTimer.start()
    
    player.play_anim("idle")
    play_show_bubble_anim()
    _play_sound($StartJumpSound)

func exit():
    death_zone_hurtbox.toggle_active(not _keep_hurtbox_disabled)

    $JumpDurationTimer.stop()

    play_hide_bubble_anim()
    _play_sound($StopJumpSound)

    

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

func _play_sound(audio_player : AudioStreamPlayer):
    audio_player.pitch_scale = randf_range(0.8,1.2)
    audio_player.play()

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("dash"):
        _keep_hurtbox_disabled = true
        state_machine.transition_to("QuickDashingState")
        return

    if event.is_action_pressed("jump"):
        state_machine.transition_to("MovingState")
        get_viewport().set_input_as_handled()
        return
    
    if event.is_action_pressed("use_ability"):
        player.use_explosion_ability()
        state_machine.transition_to("MovingState")
        return

func physics_update(delta: float):
    _accoumulated_sample_time += delta
    
    var direction = Input.get_vector("move_left","move_right","move_up","move_down")
    
    if player.extra_velocity:
        player.velocity = player.extra_velocity
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,direction * move_speed * get_speed_modifier(), decay, delta)
    player.move_and_slide()

    if direction != Vector2.ZERO:
        player.last_direction = direction

func _on_jump_duration_timer_timeout() -> void:
    state_machine.transition_to("MovingState")
    pass # Replace with function body.

func get_speed_modifier() -> float:
    var sample_point = clampf(_accoumulated_sample_time/sample_duration,speed_curve.min_domain,speed_curve.max_domain)
    return speed_curve.sample(sample_point)
    # if _accoumulated_sample_time > sample_duration:
    #     return speed_curve.sample(1)
    # else:
    #     return speed_curve.sample(_accoumulated_sample_time/sample_duration)