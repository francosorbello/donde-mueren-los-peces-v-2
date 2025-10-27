extends BoolPersistentEventConditional
class_name BoolTempEventConditional

func get_event(cached_events : Dictionary[String,float]) -> PersistentEvent:
	var result = super(cached_events)
	breakpoint
	if not result:
		return get_event_from_blackboard()
	
	return result

func get_event_from_blackboard() -> PersistentEvent:
	var blackboard = get_tree().get_first_node_in_group("blackboard") as GameBlackboard
	if blackboard:
		return blackboard.get_temp_event(event_name)
	return null
