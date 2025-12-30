extends Node
class_name ToggleAction

enum ToggleType {
    AUTOMATIC, # target is toggled between enabled and disabled depending on which state they are
    MANUAL, # target switches to state set on `toggle_to` variable
}

enum ToggleValue {
    DISABLE,
    ENABLE,
}

@export var evaluator : PersistentEventEvaluator
@export var target : Node

@export_category("Toggle type")
@export var toggle_type : ToggleType = ToggleType.AUTOMATIC
@export var toggle_to : ToggleValue = ToggleValue.DISABLE

func _ready():
    if not evaluator:
        for child in get_children():
            if child is PersistentEventEvaluator:
                evaluator = child
                break

    if evaluator:
        evaluator.evaluator_succeded.connect(_on_evaluator_succeded)
        evaluator.evaluate()

func _on_evaluator_succeded():
    if toggle_type == ToggleType.MANUAL:
        do_manual_toggle()
        return
        
    toggle_target()

func toggle_target():
    if target is Area2D:
        target.set_deferred("monitorable", not target.monitorable)
        target.set_deferred("monitoring", not target.monitoring)
        return

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

func do_manual_toggle():
    match toggle_to:
        ToggleValue.ENABLE:
            enable_target()
        ToggleValue.DISABLE:
            disable_target()