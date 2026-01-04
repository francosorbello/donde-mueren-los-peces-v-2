extends AudioStreamPlayer

@export var initial_stream_name : String
@export var streams : Dictionary[String, AudioStream]
@export var transition_time : float = 0.5
var _current_tween : Tween

var _initial_volume : float

func _ready():
    _initial_volume = volume_linear
    play()

func start_music(stream_name : String):
    assert(streams.has(stream_name),"No stream named "+stream_name)

    stream = streams[stream_name]
    play()
    if volume_linear < _initial_volume:
        _tween_volume(_initial_volume)

func stop_music():
    _tween_volume(0).tween_callback(func(): stop())

func transition_to(stream_name : String):
    assert(streams.has(stream_name),"No stream named "+stream_name)

    var stop_tween = _tween_volume(0)
    stop_tween.tween_callback(
        func(): 
            stop()
            stream = streams[stream_name]
    )
    stop_tween.tween_callback(
        func(): 
            play()
            _tween_volume(_initial_volume)
    )
        

func _tween_volume(to_value : float, time : float = transition_time) -> Tween:
    if _current_tween and _current_tween.is_running():
        _current_tween.kill()
    _current_tween = create_tween()

    _current_tween.tween_property(self,"volume_linear",to_value,time)
    return _current_tween