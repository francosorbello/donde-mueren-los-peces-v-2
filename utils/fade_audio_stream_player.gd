extends AudioStreamPlayer

@export var fade_in_duration : float = 1
@export var fade_out_duration : float = 1

var _initial_volume : float

func _ready() -> void:
    _initial_volume = volume_db

func play_with_fade_in(duration : float = fade_in_duration) -> Tween:
    volume_db = -80
    var tween := create_tween()
    tween.tween_property(self,"volume_db",_initial_volume,duration)
    play()
    return tween

func stop_with_fade_out(duration : float = fade_out_duration) -> Tween:
    var tween := create_tween()

    tween.tween_property(self,"volume_db",-80,duration)
    tween.finished.connect(func():
        stop()
    )

    return tween
