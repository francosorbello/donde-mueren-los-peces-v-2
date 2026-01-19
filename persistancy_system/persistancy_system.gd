extends Node
class_name PersistencySystem

static func set_event(ev_name : String, ev_value : float):
	if ev_name.is_empty():
		return
	var current_save = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	# prints("Current save:",  current_save, current_save.resource_name, current_save.resource_path)
	if current_save:
		if (current_save.persistent_event_exists(ev_name)):
			current_save.set_persistent_event(ev_name,ev_value)
		else:
			current_save.add_persistent_event(ev_name,ev_value)
		
		GlobalSignal.event_set.emit(PersistentEvent.new(ev_name,ev_value), current_save.persistent_events.duplicate())

static func get_event(ev_name : String) -> PersistentEvent:
	if ev_name.is_empty():
		return null
	var current_save = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	if current_save:
		return current_save.get_persistent_event(ev_name)

	return null
