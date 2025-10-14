@tool
extends Node2D

var icon : Texture2D:
	set(value):
		icon = value
		# if Engine.is_editor_hint():
		$FloatingSprite.texture = value

@export var item : AnItem:
	set(value):
		item = value
		if Engine.is_editor_hint():
			if item:
				icon = item.world_icon
				create_event()
			else:
				icon = null

@export var event_name : String
@export_tool_button("Generate event name") var create_event_action = create_event ## Generates event name based on item name

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if event_name:
		$PersistentEventEvaluator/BoolPersistentEventConditional.event_name = event_name
		$PersistentEventEvaluator.evaluate()
	
	if item:
		icon = item.world_icon

func _on_better_interactable_component_on_interact() -> void:
	var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
	if inventory_manager and item:
		inventory_manager.add_item(item)
		PersistencySystem.set_event(event_name,1.0)
	
	# queue_free()

func create_event():
	if item:
		event_name = "item_%s_picked_up"%_get_event_name()

## Generates event name based on item name
func _get_event_name() -> String:
	if item:
		var value = item.item_name
		value = value.to_lower()
		value = value.replace(" ","_")
		return value
	
	return ""

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
	queue_free()
