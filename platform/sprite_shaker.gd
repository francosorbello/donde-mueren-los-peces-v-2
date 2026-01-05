@tool
extends Node2D

@export_tool_button("test shake") var test_shake_action = _test_shake
@export var shake_offset : Vector2
@export var shake_curve : Curve
@export var shake_length : float = 0.5
@export var distance_error : float = 0.05
var target : Node2D

var shake_intensity = 0.0
var shake_duration = 0.0
var time_elapsed = 0.0
var original_position = Vector2.ZERO


var _target_position : Vector2
var _shake_elapsed : float = -1
var _mod : float = 1

func _test_shake():
    start_shake(5,5)

func _ready():
    target = get_parent()
    original_position = target.position

func _physics_process(delta):
    if Engine.is_editor_hint():
        return
    if shake_duration > 0:
        time_elapsed += delta
        shake_duration -= delta
        
        if target.position.distance_to(_target_position) < distance_error:
            _update_target_position()
            _shake_elapsed = shake_length

        # target.position = FreyaMath.lerp_exp_decay(target.position,_target_position + _target_position,10,delta)
        target.position = FreyaMath.move_towards_linear_vector_2(target.position,_target_position,get_shake_intensity(time_elapsed),delta)
        _shake_elapsed -= delta
    else:
        # Reset position when shake is finished
        target.position = original_position

func start_shake(intensity, duration):
    _update_target_position()
    shake_intensity = intensity
    shake_duration = duration
    time_elapsed = 0.0
    

func get_shake_intensity(progress : float) -> float:
    return shake_curve.sample(progress/shake_duration) * shake_intensity

func _update_target_position():
    _target_position = original_position + shake_offset * _mod
    _mod *= -1