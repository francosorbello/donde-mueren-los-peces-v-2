extends Node

func _ready() -> void:
    await get_tree().process_frame
    var player : APlayer= get_tree().get_first_node_in_group("player")
    assert(player)
    player.disable_controls()

    await get_tree().create_timer(1).timeout
    var fade_rect = GlobalData.main_screen_manager.get_outro_fade_rect()
    fade_rect.fade_out()
