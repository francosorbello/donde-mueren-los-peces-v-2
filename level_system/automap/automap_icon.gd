@tool
extends GraphElement

@export var level_id : String:
    set(value):
        level_id = value
        _set_name()

@export var related_event : String:
    set(value):
        related_event = value
        _set_name()

@export var icon : Texture2D:
    set(value):
        icon = value
        if Engine.is_editor_hint() and is_node_ready():
            $Icon.texture = value

@export var icon_scale : Vector2 = Vector2.ONE:
    set(value):
        icon_scale = value
        if Engine.is_editor_hint() and is_node_ready():
            $Icon.scale = value

@export var icon_position : Vector2 = Vector2.ZERO:
    set(value):
        icon_position = value
        if Engine.is_editor_hint() and is_node_ready():
            $Icon.position = value

var can_be_visible : bool = true

func _validate_property(property : Dictionary) -> void:
    if property.name == "icon_scale":
        property.hint = PROPERTY_HINT_LINK

func _ready() -> void:
    if Engine.is_editor_hint():
        return

    hide()
    
    await get_tree().process_frame
    
    $Icon.texture = icon
    $Icon.scale = icon_scale
    $Icon.position = icon_position
    
    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = related_event
    $PersistentEventEvaluator.evaluate()

func show_visual(visited_levels : Array[String]):
    if can_be_visible and visited_levels.has(level_id) :
        show()

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    print("Icon %s cant be visible"%name)
    can_be_visible = false
    hide()
    pass # Replace with function body.

func _set_name():
    if Engine.is_editor_hint() and is_node_ready():
        name = "IconFor (%s) (%s)"%[level_id,related_event]