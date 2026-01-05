extends Node

@export var speed : float = 100
@export var treshold : float = 1.0
@export var animation_player : AnimationPlayer

var c_owner : Node2D

var _current_tween : Tween

func _ready():
    c_owner = get_parent()

func move_to(pos : Vector2) -> Tween:
    if _current_tween and _current_tween.is_running():
        _current_tween.kill()

    animation_player.play("move")

    var dist = pos.distance_to(c_owner.global_position)
    
    _current_tween = create_tween()
    _current_tween.tween_property(c_owner,"global_position",pos,dist/speed)    
    _current_tween.tween_callback(func():
        animation_player.play("idle")
    )

    return _current_tween
