extends Node2D
class_name BetterInteractableComponent

@export var is_interactable : bool = true
@export var debug_name : String

signal on_interact
signal on_hover
signal on_leave

var outline_component : OutlineComponent

func _ready() -> void:
    for child in get_children():
        if child is OutlineComponent:
            outline_component = child

func interact():
    if is_interactable:
        on_interact.emit()

func hover_interactable():
    on_hover.emit()
    if outline_component:
        var color = Color.WHITE if is_interactable else Color.RED
        outline_component.enable_outline(color)

func leave_interactable():
    on_leave.emit()
    if outline_component:
        outline_component.disable_outline()