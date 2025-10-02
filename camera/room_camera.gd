extends Camera2D

@export var target_to_follow : Node2D

@export var room_size = Vector2(288,270)
@export var follow_smoothing : float = 10

var current_room : Vector2
var _target_pos : Vector2

func _ready():
    if target_to_follow:
        current_room = get_room_from_position(target_to_follow.global_position)
        _target_pos = calculate_room_center(current_room)
        position = _target_pos

func calculate_room_center(room : Vector2) -> Vector2:
    return room * room_size + (room_size/2)

func get_room_from_position(pos : Vector2) -> Vector2:
    return (pos / room_size).floor()

func _physics_process(_delta):
    if target_to_follow:
        var target_room = get_room_from_position(target_to_follow.global_position)
        if target_room != current_room:
            current_room = target_room
            _target_pos = calculate_room_center(current_room)
            tween_to_pos(_target_pos)

func tween_to_pos(pos : Vector2):
    var tween := create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)
    tween.tween_property(self,"global_position",pos,follow_smoothing)