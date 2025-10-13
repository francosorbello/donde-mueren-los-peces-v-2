extends Node
class_name PersistentEventEvaluator

signal evaluator_succeded
signal evaluator_failed

var conditionals : Array[PersistentEventConditional] = []

func _ready():
	GlobalSignal.event_set.connect(_on_event_set)
	evaluate()

func _on_event_set(_ev, cached_events):
	evaluate(cached_events)

func get_conditionals() -> Array[PersistentEventConditional]:
	var result : Array[PersistentEventConditional] = []
	for child in get_children():
		if child is PersistentEventConditional:
			result.append(child)

	return result


func evaluate(cached_events : Dictionary[String, float] = {}):
	if conditionals.is_empty():
		conditionals = get_conditionals()
	
	for cond in conditionals:
		if not cond.evaluate(cached_events):
			evaluator_failed.emit()
			return

	evaluator_succeded.emit()
