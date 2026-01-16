extends Node
class_name CameraShakeComponent

@export var shake_strength : float = 1
@export var shake_direction : Vector2 = Vector2(1,0)

var camera : Camera2D
var shake_duration : float = 0
var shaking = false
var _strength : float = 0

func start_shake(cam_2d : Camera2D, duration : float):
    camera = cam_2d
    shake_duration = duration
    
    shaking = true
    _strength = shake_strength
    if duration > 0:
        get_tree().create_timer(shake_duration).timeout.connect(stop_shake)

func stop_shake():
    var tween := create_tween()
    tween.tween_property(self,"_strength",0,0.5)
    tween.tween_callback(func():
        shaking = false
    )

func _process(_delta: float) -> void:
    if not shaking or not camera:
        return

    camera.offset = random_offset()
    
func random_offset():
    return Vector2(
        randf_range(-_strength,_strength),
        0,
        )

