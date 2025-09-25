extends AnimatableBody2D

var _direction : Vector2
var speed : float = 200
var accel : float = 5
signal popped(node)

func start(dir : Vector2):
    _direction = dir
    $MoveTimer.start()

func _physics_process(delta):
    if _direction and $MoveTimer.time_left > 0:
        # position += _direction * delta * speed
        position
    
func _on_dead_timer_timeout() -> void:
    popped.emit(self)

