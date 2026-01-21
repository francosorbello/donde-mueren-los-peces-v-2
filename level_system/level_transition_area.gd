extends Area2D

enum TransitionDirection{
    TD_UP,
    TD_DOWN,
    TD_LEFT,
    TD_RIGHT
}

@export var next_level_id : String
@export var direction : TransitionDirection

## workaround we have multiple transitions to the same room [br]
## set the position you want the player to spawn on the next room
@export var override_position : Vector2 = Vector2.ZERO

func do_transition():
    set_deferred("monitorable",false)
    set_deferred("monitoring",false)
    
    if next_level_id.is_empty():
        push_error("NO NEXT LEVEL ID")
        return
    
    var extra_data = {
        "direction": _transition_direction_to_vector(direction),
        "override_position" : override_position 
    }
    GlobalSignal.level_change_requested.emit(next_level_id, extra_data)

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