@tool
extends SimpleDoor

@export var related_key : AnItem
@export var related_event : String

func _ready():
    assert(not related_event.is_empty(), "No related event on door %s"%name)
    assert(related_key != null,"No related key on door %s"%name)

    $ConsumeItemArea.related_item = related_key
    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = related_event
    $PersistentEventEvaluator.evaluate()

func _on_consume_item_area_item_consumed(item: AnItem) -> void:
    assert(item == related_key,"Received %s instead of %s"%[item.item_name,related_key.item_name])    
    PersistencySystem.set_event(related_event,1.0)

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    do_toggle()
