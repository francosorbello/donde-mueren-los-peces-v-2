extends Area2D

enum TransitionDirection{
    TD_UP,
    TD_DOWN,
    TD_LEFT,
    TD_RIGHT
}

@export var next_level_id : String
@export var direction : TransitionDirection

func do_transition():
    if next_level_id.is_empty():
        push_error("NO NEXT LEVEL ID")
        return
    
    GlobalSignal.level_change_requested.emit(next_level_id, _transition_direction_to_vector(direction))

func _on_body_entered(body: Node2D) -> void:
    if body is APlayer:
        do_transition()

func _transition_direction_to_vector(dir : TransitionDirection) -> Vector2:
    match dir:
        TransitionDirection.TD_UP:
            return Vector2.UP
        TransitionDirection.TD_DOWN:
            return Vector2.DOWN
        TransitionDirection.TD_LEFT:
            return Vector2.LEFT
        TransitionDirection.TD_RIGHT:
            return Vector2.RIGHT

    return Vector2.ZERO