extends Area2D

var player : APlayer

func _on_body_entered(body: Node2D) -> void:
    if body is APlayer:
        player = body
        start_outro()
    pass # Replace with function body.

func start_outro():
    player.disable_controls()
    
    var fade_rect = GlobalData.main_screen_manager.get_outro_fade_rect()
    fade_rect.anim_duration = 1.5

    CommonSfxPlayer.play_sound("noise_transition")
    var tween = fade_rect.fade_in()
     
    tween.tween_callback(func():
        GlobalSignal.level_change_requested.emit("lvl_zone_4_last_room",{"direction" : Vector2.ZERO})
    )
    