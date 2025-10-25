extends Node2D

@export var activated_event : String

var activated : bool = false

func _ready() -> void:
    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = activated_event
    $PersistentEventEvaluator.evaluate()

func _on_better_interactable_component_on_interact() -> void:
    if activated:
        return
    
    PersistencySystem.set_event(activated_event,1.0)
    activated = true

func flip_sprite():
    $Sprite2D.flip_h = true

func set_activated():
    $Sprite2D.flip_h = true
    $BetterInteractableComponent.set_deferred("is_interactable",false)

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    set_activated()
