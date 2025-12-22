extends Node2D

@export var dialogue : DialogueResource

func _ready() -> void:
    await get_tree().create_timer(2).timeout
    DialogueManager.show_dialogue_balloon(dialogue,"start")