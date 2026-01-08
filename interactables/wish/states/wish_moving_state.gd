extends State

@export var moving_speed : float = 50
@export var move_from_initial_pos : bool = true

var _initial_pos : Vector2
var _moving_tween : Tween

func enter():
    if move_from_initial_pos and _initial_pos == Vector2.ZERO:
        _initial_pos = state_owner.global_position
    do_move()


func do_move():
    await get_tree().create_timer(2).timeout
    move_to(get_random_position()).tween_callback(do_move)
    

func get_random_position() -> Vector2:
    var move_range : Vector2 = state_owner.moving_range
    
    var pos : Vector2 = state_owner.global_position
    if move_from_initial_pos:
        pos = _initial_pos

    pos.x += randf_range(-move_range.x,move_range.x)
    pos.y += randf_range(-move_range.y,move_range.y)

    return pos

func move_to(pos : Vector2) -> Tween:
    if _moving_tween and _moving_tween.is_running():
        _moving_tween.kill()

    var dist = pos.distance_to(state_owner.global_position)

    _moving_tween = create_tween()
    _moving_tween.set_trans(Tween.TRANS_SINE)
    _moving_tween.set_ease(Tween.EASE_IN_OUT)
    _moving_tween.tween_property(state_owner,"global_position",pos,dist/moving_speed)

    return _moving_tween