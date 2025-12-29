extends CutsceneAction

@export var target : Node

func do_action():
    if target is CanvasItem:
        target.visible = not target.visible

    if target.process_mode == Node.PROCESS_MODE_INHERIT:
        target.process_mode = Node.PROCESS_MODE_DISABLED
    else:
        target.process_mode = Node.PROCESS_MODE_INHERIT
    