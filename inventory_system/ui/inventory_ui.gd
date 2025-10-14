extends Control

@export var persistent_grid : GridContainer
@export var temp_grid : GridContainer

@export var debug_inventory : InventoryRes

var inventory_manager

func _ready() -> void:
    persistent_grid.inventory_item_selected.connect(_on_item_selected)
    temp_grid.inventory_item_selected.connect(_on_item_selected)       

    inventory_manager = get_inventory_manager()
    if inventory_manager:
        persistent_grid.inventory = inventory_manager.persistent_inventory
        temp_grid.inventory = inventory_manager.temporary_inventory
        persistent_grid.focus_grid()
    elif debug_inventory:
        persistent_grid.inventory = debug_inventory.inventory
        persistent_grid.focus_grid()


func get_inventory_manager():
    inventory_manager = get_tree().get_first_node_in_group("inventory_manager")

func show_inventory():
    show()

func hide_inventory():
    hide()

func _on_item_selected(item : AnItem):
    %InformationContainer/ItemIcon.texture = item.icon
    $%InformationContainer/NameLabel.text = item.item_name
    %InformationContainer/InformationLabel.text = item.descrption