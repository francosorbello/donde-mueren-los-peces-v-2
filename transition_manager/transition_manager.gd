extends Control

func fade_in() -> Tween:
    var tween := create_tween()

    tween.tween_property($ColorRect,"modulate",Color.BLACK,1)

    return tween

func fade_out() -> Tween:
    var tween := create_tween()

    tween.tween_property($ColorRect,"modulate",Color(0,0,0,0),1)

    return tween

