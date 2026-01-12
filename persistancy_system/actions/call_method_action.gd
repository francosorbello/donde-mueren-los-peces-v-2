extends Node
class_name CallMethodAction

@export var target : Node
@export var method_name : StringName
@export var delay : float = 0

var evaluator : PersistentEventEvaluator

func _ready():
    for child in get_children():
        if child is PersistentEventEvaluator:
            evaluator = child
            break
    assert(evaluator != null, "(%s) Add a evaluator as a child of this node"%name)
    evaluator.evaluator_succeded.connect(_on_evaluator_succeded)
    evaluator.evaluate()

func _on_evaluator_succeded():
    assert(target)
    assert(target.has_method(method_name))

    if delay > 0:
        await get_tree().create_timer(delay).timeout

    target.call_deferred(method_name)