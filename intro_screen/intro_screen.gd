extends Control

func _ready():
    intro_anim()

func intro_anim():
    $Container.modulate.a = 0
    var tween := create_tween()

    tween.tween_interval(1)
    tween.tween_property($Container,"modulate",Color.WHITE,1)
    tween.tween_interval(3)    
    tween.tween_property($Container,"modulate",Color(1,1,1,0),1)
    tween.finished.connect(func():
        GlobalData.main_screen_manager.transition_to("MainMenu")
    )
