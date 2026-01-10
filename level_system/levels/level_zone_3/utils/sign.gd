extends Sprite2D

@export var dialogue : DialogueResource

func _on_better_interactable_component_on_interact() -> void:
    # DialogueManager.show_dialogue_balloon(dialogue,"start")
    GlobalData.start_dialogue(dialogue,"start",self)
