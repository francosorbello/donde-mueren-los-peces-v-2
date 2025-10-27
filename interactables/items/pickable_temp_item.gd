extends Node2D

var evaluator : PersistentEventEvaluator 

var event_setter : PersistentEventSetter

func _ready() -> void:
    for child in get_children():
        if child.has_signal("interacted_with_item"):
            child.interacted_with_item.connect(_on_interactable_item_interacted_with_item)
        if child is PersistentEventEvaluator:
            evaluator = child
            evaluator.evaluator_succeded.connect(_on_evaluator_succeed)
        if child is PersistentEventSetter:
            event_setter = child
    
    if evaluator:
        evaluator.evaluate()


func _on_interactable_item_interacted_with_item(item: AnItem) -> void:
    var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
    if inventory_manager:
        inventory_manager.add_item(item)
        event_setter.set_event(1.0)

func _on_evaluator_succeed():
    queue_free()