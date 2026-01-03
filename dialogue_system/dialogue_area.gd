extends Area2D

@export var dialogue : DialogueResource
@export var repeatable : bool = false
@export var remove_on_event : String
@export var target : Node2D

func _ready():
    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = remove_on_event
    $PersistentEventEvaluator.evaluate()

func _on_body_entered(body: Node2D) -> void:
    if body is APlayer:
        start_dialogue.call_deferred()

func start_dialogue():
    GlobalData.start_dialogue(dialogue,"start",target)
    PersistencySystem.set_event(remove_on_event,true)

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    if not repeatable:
        queue_free()

func do_toggle():
    monitorable = not monitorable
    monitoring = not monitoring