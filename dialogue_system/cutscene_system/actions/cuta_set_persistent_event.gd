extends CutsceneAction

@export var event_to_set : String = ""
@export var value : float = 1.0

func do_action():
    assert(not event_to_set.is_empty())
    PersistencySystem.set_event(event_to_set,value)