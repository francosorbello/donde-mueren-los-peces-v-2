extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

@export var soften_color : Color

var last_direction : Vector2

func _unhandled_input(event):
    if event.is_action_pressed("shoot_bubble"):
        $StateMachine.transition_to("ShootingBubbleState")
        return
    
    if event.is_action_pressed("attack"):
        var direction = Input.get_vector("move_left","move_right","move_up","move_down")
        if direction == Vector2.ZERO:
            direction = last_direction
        $SlashAttack.do_attack(direction)
        return

    if event.is_action_pressed("use_ability") and $StateMachine.current_state.name != "ShootingBubbleState":
        var bubble = bubble_manager.get_closest_to(global_position)
        if bubble:
            # $StateMachine.send_message_to("DashingState",{"bubble": bubble})
            # $StateMachine.transition_to("DashingState")
            bubble.explode()

func play_anim(anim_name : String):
    if $AnimationPlayer.current_animation != anim_name:
        $AnimationPlayer.play(anim_name)

func soften_sprite(do_soften : bool):
    var tween := create_tween()
    var col = Color.WHITE
    if do_soften:
        col = soften_color

    tween.tween_property($Sprite2D,"modulate",col,0.2)
