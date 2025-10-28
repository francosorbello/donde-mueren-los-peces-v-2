extends Node

@export var item_follower_scene : PackedScene
@export var follow_target : Marker2D

var player : APlayer

var inventory_manager : Node

func _ready() -> void:
    player = get_parent()

    inventory_manager = get_tree().get_first_node_in_group("inventory_manager")
    if inventory_manager:
        var temp_inv = inventory_manager.temporary_inventory as AnInventory
        temp_inv.item_added.connect(_on_item_added)
        temp_inv.item_removed.connect(_on_item_removed)
        spawn_temp_items()


func _on_item_added(an_item : AnItem):
    spawn_temp_item(an_item)

func _on_item_removed(an_item : AnItem):
    destroy_temp_item(an_item)

func spawn_temp_items():
    if inventory_manager:
        var temp_inv : AnInventory = inventory_manager.temporary_inventory
        for item in temp_inv.items:
            spawn_temp_item(item)

func spawn_temp_item(item : AnItem):
    var follow_target_instance = item_follower_scene.instantiate() as Node2D
    follow_target_instance.global_position = player.global_position
    follow_target_instance.setup(item,follow_target)
    add_child(follow_target_instance)

func destroy_temp_item(item : AnItem):
    for child in get_children():
        if child.item.item_id == item.item_id:
            child.queue_free()
            return