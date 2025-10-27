extends Node2D

@export var related_event : String
@export var related_items : Array[AnItem]

func _ready():
    for child in get_children():
        if child is Area2D:
            child.item_consumed.connect(_on_item_consumed)

    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = related_event
    await get_tree().process_frame
    $PersistentEventEvaluator.evaluate()    

func _on_item_consumed(_item : AnItem):
    related_items.erase(_item)
    if related_items.is_empty():
        PersistencySystem.set_event(related_event,1.0)

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    queue_free()
