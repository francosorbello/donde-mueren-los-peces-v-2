extends CharacterBody2D

@export var speed : float = 100
@export var accel : float = 2

func _physics_process(_delta):
    var direction = Input.get_vector("move_left","move_right","move_up","move_down")
    if direction:
        play_anim("move")
        if $Timer.time_left == 0:
            $Timer.start()
            $AudioStreamPlayer.play()
    else:
        play_anim("idle")
    # velocity = direction * speed
    velocity = lerp(velocity,direction * speed, _delta * accel)
    move_and_slide()

func play_anim(anim_name : String):
    if $AnimationPlayer.current_animation != anim_name:
        $AnimationPlayer.play(anim_name)