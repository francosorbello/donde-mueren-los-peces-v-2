@tool
extends SimpleDoor

@export var door_opened_event : String
@export_category("Key related")
@export var requires_special_key : bool = false
@export var related_key : AnItem

func _ready():
	super._ready()
	if Engine.is_editor_hint():
		return

	assert(not door_opened_event.is_empty(), "No related event on door %s"%name)
	if requires_special_key:
		assert(related_key != null,"No related key on door %s"%name)

	$PersistentEventEvaluator/BoolPersistentEventConditional.event_name = door_opened_event
	$PersistentEventEvaluator.evaluate()

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
	do_toggle.call_deferred()

func _on_detect_player_area_body_entered(body: Node2D) -> void:
	if body is APlayer:
		_try_open_door()

func _try_open_door():
	var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
	# breakpoint
	if inventory_manager:
		var inv = inventory_manager.persistent_inventory as AnInventory 
		for item in inv.items:
			if item is not DoorKeyItem:
				continue

			var can_open = false
			if requires_special_key:
				can_open = inv.has_item(related_key) 
			else:
				can_open = item.key_type == DoorKeyItem.KeyType.SIMPLE 

			if can_open:
				inv.remove_from_inventory(item)
				PersistencySystem.set_event(door_opened_event,1.0)
