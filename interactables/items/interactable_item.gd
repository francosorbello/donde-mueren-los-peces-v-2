@tool
extends Node2D

var icon : Texture2D:
    set(value):
        icon = value
        # if Engine.is_editor_hint():
        $FloatingSprite.texture = value

@export var item : AnItem:
    set(value):
        item = value
        create_event()
        if Engine.is_editor_hint() and is_node_ready():
            if item:
                icon = item.world_icon
            else:
                icon = null

@export var event_name : String

signal interacted_with_item(item : AnItem)

func _ready():
    if Engine.is_editor_hint():
        return

    if item:
        icon = item.world_icon

func _on_better_interactable_component_on_interact() -> void:
    if item:
        interacted_with_item.emit(item)

func create_event():
    if not item:
        return
    
    var prefix = "item"
    if item.type == AnItem.ItemType.Ability:
        prefix = "ability"
    
    event_name = "%s_%s_picked_up"%[prefix,_get_event_name()]

## Generates event name based on item name
func _get_event_name() -> String:
    if item:
        var value = item.item_name
        value = value.to_lower()
        value = value.replace(" ","_")
        return value
    
    return ""