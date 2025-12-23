extends TextureRect

@export var show_position : Vector2
@export var hide_pos : Vector2
@export var anim_time : float = 0.5

func _ready():
    position = hide_pos
    show_portrait()

func show_portrait():
    move_to_anim(show_position)
    pass

func hide_portrait():
    move_to_anim(hide_pos)
    pass

func move_to_anim(pos : Vector2):
    var tween := create_tween()
    
    tween.tween_property(self,"position",pos,anim_time)