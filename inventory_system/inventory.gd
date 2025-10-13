extends Node
class_name AnInventory

@export var items : Array[AnItem]

func add_to_inventory(item : AnItem):
    if not items.has(item):
        items.append(item)

func remove_from_inventory(item : AnItem):
    if items.has(item):
        items.erase(item)

func get_by_name(item_name : String) -> AnItem:
    for item in items:
        if item.item_name == item_name:
            return item

    return null

func clear():
    items.clear()
