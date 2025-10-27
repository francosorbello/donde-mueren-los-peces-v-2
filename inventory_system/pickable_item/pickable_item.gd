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
	if not item:
		return

	if item.type == AnItem.ItemType.Ability:
		var saved_game = IndieBlueprintSaveManager.current_saved_game as ASavedGame
		if saved_game:
			saved_game.add_ability(item)
			PersistencySystem.set_event(event_name,1.0)
		return

	var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
	if inventory_manager:
		inventory_manager.add_item(item)
		if item.is_persistent:
			PersistencySystem.set_event(event_name,1.0)
		else:
			var blackboard : GameBlackboard = get_tree().get_first_node_in_group("blackboard")
			print(blackboard)
			if blackboard:
				blackboard.add_temp_event(event_name,1.0)
	
	# queue_free()

func create_event():
	if not item:
		return
	
	var prefix = "item"
	if item.type == AnItem.ItemType.Ability:
		prefix = "ability"
	
	event_name = "%s_%s_picked_up"%[prefix,_get_event_name()]

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
