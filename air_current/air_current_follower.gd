extends PathFollow2D
class_name AirCurrentFollower

@export var initial_speed : float = 20
@export var max_speed : float = 50
@export var time_to_reach_max_speed : float = 1

signal finished_path

var moving : bool = false
var current_direction : Vector2

var _prev_pos : Vector2
var _accoumulated_sample_time : float

func reset():
    progress_ratio = 0
    h_offset = 0
    v_offset = 0
    _accoumulated_sample_time = 0

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
    print("Stoping")
    moving = false
    reset()

func _physics_process(delta):
    if not moving:
        return
    if progress_ratio > 0.99:
        print("progress finished?")
        finished_path.emit()
        stop()
        return
    
    progress += delta * get_speed()
    current_direction = (_prev_pos-global_position).normalized()
    _prev_pos = global_position
    _accoumulated_sample_time += delta

    
func get_speed():
    return lerp(
        initial_speed,
        max_speed,
        max(_accoumulated_sample_time/time_to_reach_max_speed,1)
    )
