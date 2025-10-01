extends CharacterBody2D

@export var accel : float = 5
@export var travel_data : BubbleCBData

var _direction : Vector2
var _initial_pos : Vector2
var _prev_pos : Vector2
var _accomulated_distance_traveled : float

signal popped(node)

func start(dir : Vector2):
    _direction = dir
    _initial_pos = global_position
    _prev_pos = global_position
    _accomulated_distance_traveled = 0

func start_peak(dir : Vector2):
    start(dir)


func _physics_process(delta):
    var dir = _direction

    _accomulated_distance_traveled += (_prev_pos - global_position).length()
    _prev_pos = global_position
    
    if  _accomulated_distance_traveled > travel_data.travel_distance:
        dir = Vector2.ZERO

    velocity = dir * travel_data.speed
    # move_and_slide()

    var collision = move_and_collide(velocity * delta)
    if collision:
        _direction = collision.get_normal()
    
func _on_dead_timer_timeout() -> void:
    popped.emit(self)
    pop()

func pop():
    queue_free()

func explode():
    pass

func _on_hitbox_on_hit(hit_data: HitData) -> void:
    print("Hit")
    start(-hit_data.collision_normal)
