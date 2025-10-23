extends Resource
class_name AnItem

enum ItemType {
    Inventory,
    Ability,
}

@export var item_name : String
@export_multiline var descrption : String
@export var type : ItemType = ItemType.Inventory
@export var quantity : int = 1
@export var is_persistent : bool = false
@export var icon : Texture2D
@export var world_icon : Texture2D

