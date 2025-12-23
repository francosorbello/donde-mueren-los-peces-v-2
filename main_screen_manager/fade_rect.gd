extends ColorRect

@export var anim_duration : float = 0.5

func _ready():
    # color.a = 0
    pass

func fade_in() -> Tween:
    var tween := create_tween()

    tween.tween_property(self,"color:a",1,anim_duration)

    return tween

func fade_out() -> Tween:
    var tween := create_tween()

    tween.tween_property(self,"color:a",0,anim_duration)

    return tween