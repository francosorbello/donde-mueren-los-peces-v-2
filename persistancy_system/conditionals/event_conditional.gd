extends Node
class_name PersistentEventConditional

@export var event_name : String

func evaluate(_cached_events : Dictionary[String,float] = {}) -> bool:
	return true

func get_event(cached_events : Dictionary[String,float]) -> PersistentEvent:
	var ev = get_event_from_cached(cached_events)
	if ev:
		return ev
	else:
		return get_event_from_save()
	
func get_event_from_save() -> PersistentEvent:
	return PersistencySystem.get_event(event_name)

func get_event_from_cached(cached_events : Dictionary[String,float]) -> PersistentEvent:
	if cached_events.is_empty():
		return null
	
	if not cached_events.has(event_name):
		return null

	return PersistentEvent.new(event_name,cached_events[event_name])

# func _to_string() -> String:
#     return "%s evaluates %s with value %s"%[name,event_name,evaluate()]
