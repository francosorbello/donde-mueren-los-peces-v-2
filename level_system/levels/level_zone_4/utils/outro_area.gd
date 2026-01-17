extends Area2D

var player : APlayer

func _on_body_entered(body: Node2D) -> void:
    if body is APlayer:
        player = body
        start_outro()
    pass # Replace with function body.

func start_outro():
    player.disable_controls()
    
    CommonSfxPlayer.play_sound("noise_transition")
    var tween := create_tween()
    tween.tween_property($CanvasLayer/ColorRect,"modulate",Color.WHITE,1.5)
    tween.tween_callback(func():
        GlobalData.main_screen_manager.transition_to("EndDemo")
    )
    