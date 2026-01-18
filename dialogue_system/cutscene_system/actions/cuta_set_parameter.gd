extends CutsceneAction

@export var target : Node
@export var param_name : StringName
@export var param_value : Variant

func do_action():
    assert(target)
    assert(param_name in target)
    
    target.set(param_name,param_value)