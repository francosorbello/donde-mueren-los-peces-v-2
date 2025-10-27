extends Node
class_name GameBlackboard
## Blackboard to share data while on a game scene

var temp_events : Dictionary[String, float]

func add_temp_event(event_name : String, value : float):
    if event_name.is_empty():
        return
    
    temp_events[event_name] = value
    GlobalSignal.temp_event_set.emit(PersistentEvent.new(event_name,value))

func remove_temp_event(event_name : String):
    if (temp_events.erase(event_name)):
        GlobalSignal.temp_event_removed.emit(event_name)


func get_temp_event(event_name : String) -> PersistentEvent:
    if temp_events.has(event_name):
        return PersistentEvent.new(event_name,temp_events[event_name])
    return null

func clear():
    temp_events.clear()

