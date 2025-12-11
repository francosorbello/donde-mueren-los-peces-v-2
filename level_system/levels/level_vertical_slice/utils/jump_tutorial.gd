extends Node

@export var dialogue : DialogueResource
@export var pickable_item : Node2D

func _ready() -> void:
	pickable_item.picked_up.connect(_on_ability_picked_up)
	
func _on_ability_picked_up(_item : AnItem):
	DialogueManager.show_dialogue_balloon(dialogue,"start")
