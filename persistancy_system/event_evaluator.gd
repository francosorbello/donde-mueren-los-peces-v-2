extends Node
class_name PersistentEventEvaluator

signal evaluator_succeded
signal evaluator_failed

@export var autostart : bool = true
@export var debug : bool = false
var conditionals : Array[PersistentEventConditional] = []

func _ready():
	conditionals = get_conditionals()
	GlobalSignal.event_set.connect(_on_event_set)
	if autostart:
		evaluate()
	

func _on_event_set(_ev, cached_events):
	if has_valid_conditional(_ev):
		evaluate(cached_events)

func get_conditionals() -> Array[PersistentEventConditional]:
	if not conditionals.is_empty():
		return conditionals

	var result : Array[PersistentEventConditional] = []
	for child in get_children():
		if child is PersistentEventConditional:
			result.append(child)

	return result

func has_valid_conditional(for_event : PersistentEvent):
	for cond in conditionals:
		if cond.event_name == for_event.name:
			return true
	return false

func evaluate(cached_events : Dictionary[String, float] = {}):
	# conditionals = get_conditionals()
	if debug:
		print("-------")
		print("Evaluating %s with conditionals:"%get_parent().name,conditionals)

	if conditionals.is_empty():
		if debug:
			print("No conditionals. Failing")
		evaluator_failed.emit()
		return

	for cond in conditionals:
		if not cond.evaluate(cached_events):
			if debug:
				print("Conditional failed: ",cond.to_string())
				evaluator_failed.emit()
			return

	if debug:
		print("All conditionals are true. Success!")	
	evaluator_succeded.emit()
