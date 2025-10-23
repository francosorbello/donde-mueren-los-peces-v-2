extends IndieBlueprintSavedGame
class_name ASavedGame

@export var persistent_events : Dictionary[String,float]
@export var persistent_inventory : Array[AnItem]
@export var visited_levels : Array[String]
@export var unlocked_abilities : Array[AnItem]

func persistent_event_exists(ev_name : String) -> bool:
	return persistent_events.has(ev_name)

func get_persistent_event(ev_name : String) -> PersistentEvent:
	if not persistent_event_exists(ev_name):
		return null
	
	var event = PersistentEvent.new(ev_name, persistent_events[ev_name])
	return event

func set_persistent_event(ev_name : String, ev_value : float) -> bool:
	if not persistent_event_exists(ev_name):
		return false
	
	persistent_events[ev_name] = ev_value
	write_savegame()

	return true

func add_persistent_event(ev_name: String, ev_value : float = 0.0) -> bool:
	if persistent_event_exists(ev_name):
		return false

	persistent_events[ev_name] = ev_value
	write_savegame()
	return true

func add_visited_level(id : String):
	if not visited_levels.has(id):
		visited_levels.append(id)
		write_savegame()

func add_ability(ability_item : AnItem):
	if ability_item.type != AnItem.ItemType.Ability:
		return

	if not unlocked_abilities.has(ability_item):
		unlocked_abilities.append(ability_item)

	write_savegame()

func clear_save():
	persistent_events.clear()
	persistent_inventory.clear()
	visited_levels.clear()
	unlocked_abilities.clear()
	write_savegame()

