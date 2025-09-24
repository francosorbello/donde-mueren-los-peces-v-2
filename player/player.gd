extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

func play_anim(anim_name : String):
    if $AnimationPlayer.current_animation != anim_name:
        $AnimationPlayer.play(anim_name)