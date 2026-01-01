extends ColorRect

@export var anim_duration : float = 0.5

var fade_tween : Tween

func _ready():
    # color.a = 0
    pass

func fade_in() -> Tween:
    if fade_tween and fade_tween.is_running():
        fade_tween.kill()
    fade_tween = create_tween()

    fade_tween.tween_property(self,"color:a",1,anim_duration)

    return fade_tween

func fade_out() -> Tween:
    var tween := create_tween()

    tween.tween_property(self,"color:a",0,anim_duration)

    return tween