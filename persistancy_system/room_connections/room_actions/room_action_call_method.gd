extends RoomAction
class_name RoomActionCallMethod

## Set a target and the method to call for each of them
@export var targets : Dictionary[Node,StringName]

func use():
    for target in targets:
        var method_name = targets[target]
        assert(target.has_method(method_name), "Target %s doesnt have a method called %s"%[target,method_name])

        target.call(method_name)