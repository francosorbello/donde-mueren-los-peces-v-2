extends Node2D

@export var target_player : APlayer

func _ready() -> void:
    await get_tree().process_frame
    target_player = get_tree().get_first_node_in_group("player")
    $TargetFollowComponent.target = target_player.follow_target