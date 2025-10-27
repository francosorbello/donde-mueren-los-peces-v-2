@tool
extends Node2D

var evaluator : PersistentEventEvaluator 

var event_setter : PersistentEventSetter

@export var event_setters : Array[EventSetterResource]:
    set(value):
        event_setters = value
        update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
    var warnings : PackedStringArray = []
    if event_setters.is_empty():
        warnings.append("No event setters available")

    var has_evaluator : bool = false
    var has_interactable : bool = false
    for child in get_children():
        if child.has_signal("interacted_with_item"):
            has_interactable = true
        if child is PersistentEventEvaluator:
            has_evaluator = true

    if not has_evaluator:
        warnings.append("PersistentEventEvaluator child missing")
    
    if not has_interactable:
        warnings.append("InteractableItem child missing")

    return warnings

func _ready() -> void:
    if Engine.is_editor_hint():
        return
    
    for child in get_children():
        if child.has_signal("interacted_with_item"):
            child.interacted_with_item.connect(_on_interactable_item_interacted_with_item)
        if child is PersistentEventEvaluator:
            evaluator = child
            evaluator.evaluator_succeded.connect(_on_evaluator_succeed)
    
    if evaluator:
        evaluator.evaluate()


func _on_interactable_item_interacted_with_item(item: AnItem) -> void:
    var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
    if inventory_manager:
        inventory_manager.add_item(item)
        for setter in event_setters:
            setter.set_event(self,1.0)

func _on_evaluator_succeed():
    queue_free()