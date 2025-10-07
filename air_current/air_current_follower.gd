extends PathFollow2D
class_name AirCurrentFollower

@export var speed : float = 20

signal finished_path

var moving : bool = false

func reset():
    progress_ratio = 0
    h_offset = 0

func start():
    reset()
    moving = true

func start_from(pos : Vector2):
    reset()
    var distance = abs(pos.x - global_position.x)
    progress += distance
    moving = true

func stop():
    moving = false
    reset()

func _physics_process(delta):
    if not moving:
        return
    
    progress += delta * speed
    if progress_ratio > 0.97:
        finished_path.emit()
        stop()
    
