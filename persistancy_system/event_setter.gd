extends Node
class_name PersistentEventSetter

@export var event_name : String

func set_event(value : float):
    PersistencySystem.set_event(event_name,value)
