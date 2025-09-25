extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

func _unhandled_input(event):
    if event.is_action_pressed("shoot_bubble"):
        var direction = Input.get_vector("move_left","move_right","move_up","move_down")
        bubble_manager.shoot_bubble(global_position,direction)

func play_anim(anim_name : String):
    if $AnimationPlayer.current_animation != anim_name:
        $AnimationPlayer.play(anim_name)