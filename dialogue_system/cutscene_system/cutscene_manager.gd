extends Node

@export var dialogue : DialogueResource
@export var debug : bool = false

var execute_on_start : Array[CutsceneAction]
var execute_on_end : Array[CutsceneAction]
var execute_on_event : Dictionary[String, Array] = {}

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	GlobalSignal.on_dialogue_event.connect(_on_dialogue_event)

	for child in get_children():
		if child is CutsceneAction:
			if not child.enabled:
				continue

			match child.execute:
				CutsceneAction.Execute.ON_START:
					execute_on_start.append(child)
				CutsceneAction.Execute.ON_END:
					execute_on_end.append(child)
				CutsceneAction.Execute.ON_EVENT:
					if not execute_on_event.has(child.event_name):
						execute_on_event[child.event_name] = []
					execute_on_event[child.event_name].append(child)
					pass
				_:
					push_error("Execute type %s not implemented"%CutsceneAction.Execute.find_key(child.execute))

func _on_dialogue_started(_dialogue):
	if not _dialogue == dialogue:
		return
	execute_start_actions()

func _on_dialogue_ended(_dialogue):
	if not _dialogue == dialogue:
		return
	execute_end_actions()

func _on_dialogue_event(event : String):
	if not execute_on_event.has(event):
		return
	
	_execute_actions(execute_on_event[event])

func execute_start_actions():
	_execute_actions(execute_on_start)

func execute_end_actions():
	_execute_actions(execute_on_end)

func _execute_actions(actions : Array):
	for action in actions:
		if debug:
			var ev_name = action.event_name
			if ev_name.is_empty():
				ev_name = "No event"
			# print("Executing action %s on %s (event: %s) (%ss)"%[action,CutsceneAction.Execute.find_key(action.execute),ev_name,action.wait_time])
		action.do_action()
		if action.wait_time > 0:
			await get_tree().create_timer(action.wait_time).timeout
