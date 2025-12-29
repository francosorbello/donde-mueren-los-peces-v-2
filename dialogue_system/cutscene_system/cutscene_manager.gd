extends Node

@export var dialogue : DialogueResource

var execute_on_start : Array[CutsceneAction]
var execute_on_end : Array[CutsceneAction]

func _ready():
    DialogueManager.dialogue_started.connect(_on_dialogue_started)
    DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

    for child in get_children():
        if child is CutsceneAction:
            match child.execute:
                CutsceneAction.Execute.ON_START:
                    execute_on_start.append(child)
                CutsceneAction.Execute.ON_END:
                    execute_on_end.append(child)
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

func execute_start_actions():
    for action in execute_on_start:
        action.do_action()

func execute_end_actions():
    for action in execute_on_end:
        action.do_action()
