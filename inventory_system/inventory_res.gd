extends Resource
class_name InventoryRes


@export var items : Array[AnItem]

var inventory : AnInventory = null:
	get():
		if not inventory: 
			inventory = AnInventory.new()
			inventory.items = items
		
		return inventory
