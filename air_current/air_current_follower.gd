extends PathFollow2D
class_name AirCurrentFollower

@export var speed : float = 20

signal finished_path

var moving : bool = false

var _prev_pos : Vector2
var current_direction : Vector2

func reset():
    progress_ratio = 0
    h_offset = 0
    v_offset = 0

func start():
    reset()
    moving = true

func start_from(pos : Vector2):
    reset()
    var distance = abs(pos.x - global_position.x)
    progress += distance
    moving = true

func offset_by(offset : Vector2):
    var dir = Vector2(-current_direction.y,current_direction.x)
    h_offset += dir.x * offset.x
    v_offset += dir.y * offset.y

func stop():
    moving = false
    reset()

func _physics_process(delta):
    if not moving:
        return
    
    progress += delta * speed
    current_direction = (_prev_pos-global_position).normalized()
    _prev_pos = global_position

    if progress_ratio > 0.97:
        finished_path.emit()
        stop()
    
