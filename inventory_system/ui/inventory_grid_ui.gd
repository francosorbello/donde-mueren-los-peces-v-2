extends GridContainer


@export var debug_inventory : InventoryRes
@export var grid_element_scene : PackedScene

var inventory : AnInventory:
	set(value):
		inventory = value
		if inventory:
			inventory.item_added.connect(_on_element_added)
			inventory.item_removed.connect(_on_element_removed)
			create_grid()

var grid_elements : Array[Control]

signal inventory_item_selected (item : AnItem)

func _ready():
	if debug_inventory:
		inventory = debug_inventory.inventory

func create_grid():
	var prev_item : Control = null
	var i : int = 0
	for item in inventory.items:
		var grid_entry = grid_element_scene.instantiate() as Control
		grid_entry.name = "Grid Element %d"%i
		grid_entry.item = item
		grid_entry.focus_entered.connect(func():
			_on_elem_focused(grid_entry)    
		)
		add_child(grid_entry)

		if prev_item:
			grid_entry.focus_neighbor_left = prev_item.get_path()

		prev_item = grid_entry
		grid_elements.append(grid_entry)

		i+=1
		
func _on_elem_focused(element : Control):
	inventory_item_selected.emit(element.item)

func _on_element_added(item : AnItem):
	print("%s added to inventory %s?"%[item.item_name,self])
	var grid_entry = grid_element_scene.instantiate() as Control
	grid_entry.name = "Grid Element %d"%grid_elements.size()
	grid_entry.item = item
	add_child(grid_entry)
	if not grid_elements.is_empty():
		grid_entry.focus_neighbor_left = grid_elements.back()
	
	grid_elements.append(grid_entry)

func _on_element_removed(item : AnItem):
	for i in range(0, grid_elements.size()):
		var grid_entry = grid_elements[i]
		if grid_entry.item.item_name == item.item_name:            
			if not grid_entry.focus_neighbor_left.is_empty() and i < (grid_elements.size()-1):
				grid_elements[i+1].focus_neighbor_left = grid_entry.focus_neighbor_left

			grid_elements.erase(grid_entry)
			grid_entry.queue_free()
			return

func focus_grid():
	print("can i focus? ",grid_elements.size())
	if not grid_elements.is_empty():
		print("focus element ",grid_elements[0].name)
		grid_elements[0].grab_focus()
