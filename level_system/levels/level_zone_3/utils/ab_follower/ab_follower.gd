extends Sprite2D

@export var stop_treshold : float = 1

var target : Node2D

func _ready():
    await get_tree().process_frame
    # await get_tree().create_timer(1).timeout
    var player = get_tree().get_first_node_in_group("player")
    target = player.get_node("AbFollowTarget")

func get_animation_player() -> AnimationPlayer:
    return $AnimationPlayer