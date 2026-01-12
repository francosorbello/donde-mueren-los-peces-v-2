extends CutsceneAction

@export var target : Node
@export var method_name : StringName

func do_action():
    assert(target)
    assert(target.has_method(method_name), "Target doesnt have a method called "+method_name)

    target.call_deferred(method_name)
