extends Node
class_name PersistentEventEvaluator

signal evaluator_succeded
signal evaluator_failed

var conditionals : Array[PersistentEventConditional] = []

func _ready():
    GlobalSignal.event_set.connect(_on_event_set)

func _on_event_set(_ev):
    evaluate()

func get_conditionals() -> Array[PersistentEventConditional]:
    var result = []
    for child in get_children():
        if child is PersistentEventConditional:
            result.append(child)

    return result


func evaluate():
    if conditionals.is_empty():
        conditionals = get_conditionals()
    
    for cond in conditionals:
        if not cond.evaluate():
            evaluator_failed.emit()
            return

    evaluator_succeded.emit()