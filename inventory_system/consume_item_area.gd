extends Area2D

@export var related_item : AnItem

signal item_consumed(item : AnItem)

func _on_body_entered(body: Node2D) -> void:
	prints(body,"entered")
	if body is APlayer:
		try_item_unlock()

func try_item_unlock():
	var inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
	print(inventory_manager)
	# breakpoint
	if inventory_manager:
		var temporary_inventory = inventory_manager.temporary_inventory as AnInventory
		if temporary_inventory.has_item(related_item):
			print("Unlock the area!")
			temporary_inventory.remove_from_inventory(related_item)
			item_consumed.emit(related_item)
			set_deferred("monitoring",false)
