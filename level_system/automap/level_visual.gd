@tool
extends GraphElement

@export var level_id : String
@export var visual : Texture2D:
    set(value):
        visual = value
        if Engine.is_editor_hint() and $TextureRect:
            $TextureRect.texture = value


func _ready() -> void:
    if Engine.is_editor_hint():
        return
    
    hide()
    $TextureRect.texture = visual

func show_visual(visited_levels : Array[String]):
    if visited_levels.has(level_id):
        show()

func _on_node_selected() -> void:
    if Engine.is_editor_hint():
        return

    print("Selected node ",name)
    $TextureRect.modulate = Color.WHITE

func _on_node_deselected() -> void:
    if Engine.is_editor_hint():
        return

    print("Deselected node ",name)
    $TextureRect.modulate = Color(1,1,1,0.6)
    pass # Replace with function body.

func get_center_point():
    var visual_center = visual.get_size()/2
    return position_offset + visual_center


func toggle_current(is_current : bool):
    if is_current:
        _on_node_selected()
    else:
        _on_node_deselected()