@tool
extends Sprite2D

@export_enum("Kai","Ab") var character_name : String = "Kai":
    set(value):
        character_name = value
        if Engine.is_editor_hint() and is_node_ready():
            setup()

@export var dialogue : DialogueResource
@export var override_target : Node2D
@export var dialogue_ended_event : String = ""
@export var title : String = "start"

@export_category("Profiles")
@export var character_profiles : CharacterContainerResource


func _ready():
    setup()
    if Engine.is_editor_hint():
        return
    DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

    $PersistentEventEvaluator/BoolPersistentEventConditional.event_name = dialogue_ended_event
    $PersistentEventEvaluator.evaluate()

func setup():
    var character = character_profiles.get_character_named(character_name)
    assert(character != null, "No character named %s"%character_name)

    texture = character.world_sprite
    name = "WC_%s"%character_name

func _on_dialogue_ended(_dialogue):
    if _dialogue == dialogue:
        PersistencySystem.set_event(dialogue_ended_event,1.0)
        pass

func _on_better_interactable_component_on_interact() -> void:
    var _target = self
    if override_target:
        _target = override_target
    GlobalData.start_dialogue(dialogue,title,_target)


func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    print("Evaluator succeded cwith event %s"%dialogue_ended_event)
    queue_free()
    pass # Replace with function body.
