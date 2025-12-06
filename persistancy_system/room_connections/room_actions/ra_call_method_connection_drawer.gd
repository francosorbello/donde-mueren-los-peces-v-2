@tool
extends Node2D

@export var call_method_node : RoomActionCallMethod:
    set(value):
        call_method_node = value
        if Engine.is_editor_hint() and is_node_ready():
            refresh()

@export_tool_button("Refresh") var refresh_action = refresh

var _targets : Array[Node2D]

func refresh():
    _targets.clear()
    if call_method_node:
        var targets = call_method_node.targets.keys()
        if targets.is_empty():
            return
        
        for t in targets:
            if t is Node2D:
                _targets.append(t)

        queue_redraw()


func _draw() -> void:
    if _targets.is_empty() or not Engine.is_editor_hint():
        return
    
    for t in _targets:
        prints(t.global_position,t.position)
        draw_line(Vector2.ZERO,t.global_position-global_position,Color(1,1,1,0.6),1)