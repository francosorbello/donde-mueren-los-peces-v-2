extends Node
class_name DeleteAction

@export var target : Node

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
	target.queue_free()
	pass
