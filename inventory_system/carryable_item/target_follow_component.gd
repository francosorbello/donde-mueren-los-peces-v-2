extends Node2D

@export var speed : float = 1
@export var start_to_follow_distance : float = 20

@export var use_random_offset : bool = true
@export var max_offset : Vector2 = Vector2(10,10)

var target : Node2D

var _parent : Node2D
var _offset : Vector2

func _ready():
    _parent = get_parent()

    _offset.x = randf_range(-max_offset.x,max_offset.x)
    _offset.y = randf_range(-max_offset.y,max_offset.y)
    print(_offset)

func _physics_process(delta):
    if target:
        var _target_pos = target.global_position
        if use_random_offset:
            _target_pos += _offset
        _parent.global_position = FreyaMath.lerp_exp_decay(_parent.global_position,_target_pos,5,delta * speed)