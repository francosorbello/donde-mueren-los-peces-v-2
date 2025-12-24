extends TextureRect

@export var show_position : Vector2
@export var hide_pos : Vector2
@export var anim_time : float = 0.5

func _ready():
    visible = false
    position = hide_pos
    show_portrait()

func show_portrait():
    show()
    move_to_anim(show_position)
    pass

func hide_portrait():
    var tween = move_to_anim(hide_pos)
    tween.finished.connect(func():
        hide()    
    )

func move_to_anim(pos : Vector2) -> Tween:
    var tween := create_tween()
    
    tween.tween_property(self,"position",pos,anim_time)
    return tween
    