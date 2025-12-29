@tool
extends Sprite2D

@export_enum("Kai","Ab") var character_name : String = "Kai":
    set(value):
        character_name = value
        if Engine.is_editor_hint() and is_node_ready():
            setup()

@export var dialogue : DialogueResource
@export var override_target : Node2D
@export_category("Profiles")
@export var character_profiles : CharacterContainerResource

var title : String = "start"

func _ready():
    setup()

func setup():
    var character = character_profiles.get_character_named(character_name)
    assert(character != null, "No character named %s"%character_name)

    texture = character.world_sprite
    name = "WC_%s"%character_name

func _on_better_interactable_component_on_interact() -> void:
    var _target = self
    if override_target:
        _target = override_target
    GlobalData.start_dialogue(dialogue,title,_target)
