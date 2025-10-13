extends PersistentEventConditional

func evaluate(cached_events : Dictionary = {}) -> bool:
	var ev: = get_event(cached_events)
	if not ev:
		return false
	return ev.value == 1.0
