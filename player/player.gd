extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

@export var soften_color : Color

func _unhandled_input(event):
    if event.is_action_pressed("shoot_bubble"):
        $StateMachine.transition_to("ShootingBubbleState")
        # var direction = Input.get_vector("move_left","move_right","move_up","move_down")
        # bubble_manager.shoot_bubble(global_position,direction)

func play_anim(anim_name : String):
    if $AnimationPlayer.current_animation != anim_name:
        $AnimationPlayer.play(anim_name)

func soften_sprite(do_soften : bool):
    var tween := create_tween()
    var col = Color.WHITE
    if do_soften:
        col = soften_color

    tween.tween_property($Sprite2D,"modulate",col,0.2)
