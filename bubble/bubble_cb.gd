extends CharacterBody2D

@export var speed : float = 80
@export var accel : float = 5
@export var travel_distance : float = 15

var _direction : Vector2
var _initial_pos : Vector2
var _prev_pos : Vector2
var _accomulated_distance_traveled : float

signal popped(node)

func start(dir : Vector2):
    _direction = dir
    _initial_pos = global_position
    _prev_pos = global_position

func _physics_process(delta):
    var dir = _direction

    _accomulated_distance_traveled += (_prev_pos - global_position).length()
    _prev_pos = global_position
    if _accomulated_distance_traveled < travel_distance:
        print(_accomulated_distance_traveled)
    
    if  _accomulated_distance_traveled > travel_distance:
        dir = Vector2.ZERO

    if _accomulated_distance_traveled > travel_distance:
        velocity = lerp(velocity,dir * speed, delta * accel)
    else:
        velocity = dir * speed
    # move_and_slide()

    var collision = move_and_collide(velocity * delta)
    if collision:
        _direction = collision.get_normal()
    
func _on_dead_timer_timeout() -> void:
    popped.emit(self)
