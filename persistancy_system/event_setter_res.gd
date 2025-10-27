extends Resource
class_name EventSetterResource

@export var event_name : String
@export var is_persistent : bool = true

func set_event(from : Node, value : float):
    if is_persistent:
        PersistencySystem.set_event(event_name,value)
    else:
        var blackboard : GameBlackboard = from.get_tree().get_first_node_in_group("blackboard")
        if blackboard:
            blackboard.add_temp_event(event_name,value)
