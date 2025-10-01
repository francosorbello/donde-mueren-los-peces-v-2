extends Node2D

@export_flags_2d_physics var collision_mask : int

@export var use_time_slicing : bool = false
@export var time_between_calc : float = 0.1

var calculating : bool = false
var max_iterations : int = 3
var _distance : float
var _from_target : Node2D

var _initial_pos : Vector2
var _current_position : Vector2
var _remaining_distance : float
var _current_direction : Vector2
var points : Array[Vector2] = []

signal points_updated(points : Array[Vector2])

func _ready():
    pass

func start_calc(from_target : Node2D, distance : float):
    _from_target = from_target
    _initial_pos = from_target.global_position
    _distance = distance
    points.clear()

    calculating = true

func stop_calc() -> Array[Vector2]:
    calculating = false
    _from_target = null
    if use_time_slicing:
        $TimeSliceTimer.stop()
    return points

func _physics_process(_delta):
    if not calculating or not _from_target:
        return

    if use_time_slicing and $TimeSliceTimer.time_left > 0:
        return

    _current_position = _from_target.global_position
    _current_direction = (get_global_mouse_position()-_from_target.global_position).normalized()
    _remaining_distance = _distance
    points.clear()
    points.append(_from_target.global_position)

    var space_state = get_world_2d().direct_space_state
    for _i in range(0,max_iterations):
        var next_position = _current_position + _current_direction * _remaining_distance
        var query = PhysicsRayQueryParameters2D.create(_current_position,next_position,collision_mask)
        var result = space_state.intersect_ray(query)
        if result:
            _remaining_distance -= result.position.distance_to(_current_position)
            _current_position = result.position
            _current_direction = result.normal
            points.append(_current_position)
        else:
            if _i > 0:
                points.append(_current_position + _current_direction * _remaining_distance)
            else:
                points.append(_current_direction * _remaining_distance)
        pass

    # points_updated.emit(points)
    if use_time_slicing:
        $TimeSliceTimer.start(time_between_calc) 

    