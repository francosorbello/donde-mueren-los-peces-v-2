extends Node

@export_group("Debug")
@export var debug_fill : bool = false
@export var temp_items : Array[AnItem]
@export var persistent_items : Array[AnItem] 

func _ready() -> void:
	if debug_fill:
		persistent_inventory.items = persistent_items
		temporary_inventory.items = temp_items

@onready var persistent_inventory : AnInventory = $PersistentInventory
@onready var temporary_inventory : AnInventory = $TemporalInventory

func load_persistent_inventory():
	var current_save = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	if current_save:
		pass

func clear_temporary_inventory():
	temporary_inventory.clear()

func add_item(item : AnItem):
	if item.is_persistent:
		persistent_inventory.add_to_inventory(item)
	else:
		temporary_inventory.add_to_inventory(item)
