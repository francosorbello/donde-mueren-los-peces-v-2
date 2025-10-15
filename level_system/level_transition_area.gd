extends Area2D

@export var next_level_id : String

func do_transition():
    if next_level_id.is_empty():
        return
    
    GlobalSignal.level_change_requested.emit(next_level_id)

func _on_body_entered(body: Node2D) -> void:
    if body is APlayer:
        do_transition()
