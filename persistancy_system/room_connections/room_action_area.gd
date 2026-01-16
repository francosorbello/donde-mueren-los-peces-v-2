extends Area2D

@export var single_use : bool = false

var used : bool = false

func _on_body_entered(body: Node2D) -> void:
    if single_use and used:
        return
    
    if body is APlayer:
        use_actions()
        if single_use:
            used = true

func use_actions():
    for child in get_children():
        if child is RoomAction:
            child.use()
