extends IndieBlueprintSavedGame
class_name ASavedGame

@export var persistent_events : Dictionary[String,float]
@export var persistent_inventory : Array[AnItem]

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

func clear_save():
    persistent_events.clear()
    persistent_inventory.clear()
    write_savegame()