@tool
extends GraphElement

@export var level_id : String
@export var visual : Texture2D:
    set(value):
        visual = value
        if Engine.is_editor_hint():
            $TextureRect.texture = value


func _ready() -> void:
    if Engine.is_editor_hint():
        return
    
    hide()
    $TextureRect.texture = visual

func show_visual(visited_levels : Array[String]):
    if visited_levels.has(level_id):
        show()