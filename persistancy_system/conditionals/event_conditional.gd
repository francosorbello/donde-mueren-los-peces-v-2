extends Node
class_name PersistentEventConditional

@export var event_name : String

func evaluate() -> bool:
    return true

func get_event() -> PersistentEvent:
    return PersistencySystem.get_event(event_name)

