extends Node
class_name ToggleAction

@export var evaluator : PersistentEventEvaluator
@export var target : Node

func _ready():
	if evaluator:
		evaluator.evaluator_succeded.connect(_on_evaluator_succeded)

func _on_evaluator_succeded():
	toggle_target()

func toggle_target():
	if target is CanvasItem:
		if target.visible:
			disable_target()
		else:
			enable_target()
		return

	if target.process_mode == Node.PROCESS_MODE_DISABLED:
		enable_target()
	else:
		disable_target()

func disable_target():
	if target:
		if target.has_method("hide"):
			target.hide()
		target.process_mode = Node.PROCESS_MODE_DISABLED

func enable_target():
	if target:
		if target.has_method("show"):
			target.show()
		target.process_mode = Node.PROCESS_MODE_INHERIT
