@tool
extends Sprite2D

const CHARACTERS = "abcdefghijklmnopqrstuvwxyz"

@export var moving_range : Vector2 = Vector2(10,10):
	set(value):
		moving_range = value
		if Engine.is_editor_hint() and is_node_ready():
			queue_redraw()

@export_category("Dialogue")
@export var char_name : String
@export var char_dialogue : String 

var dialogue : DialogueResource

func _ready():
	if Engine.is_editor_hint():
		return
	var character = char_name
	if char_name.is_empty():
		character = "*****"

	var text = "~ start \n %s: %s \n => END"%[character,char_dialogue]
	dialogue = DialogueManager.create_resource_from_text(text)

func _draw() -> void:
	if Engine.is_editor_hint():
		var rect = Rect2(-moving_range,moving_range*2)
		draw_rect(rect,Color.WHITE,false)


func _on_better_interactable_component_on_interact() -> void:
	# DialogueManager.show_dialogue_balloon(dialogue)
	GlobalData.start_dialogue(dialogue)
	pass # Replace with function body.
