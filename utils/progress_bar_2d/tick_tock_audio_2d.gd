extends AudioStreamPlayer2D

## when timer is too short, its best to start with the fastest sound directly. Otherwise it sounds kinda bad
@export var start_fast_treshold : float = 3.0 

var duration : float
var running : bool = false

var _acc_time : float
var _treshold : float
var _current_index : int
var _treshold_time : float

var _sync_stream : AudioStreamSynchronized

func _ready():
    _sync_stream = stream

func start(time : float):
    duration = time
    running = true

    _acc_time = 0
    _current_index = 0
    if _treshold <= start_fast_treshold:
        _play_next_sound()
    else:
        _treshold = duration / 2.0
        $TresholdTimer.start(_treshold)

    play()

func _process(delta: float) -> void:
    if running:
        _acc_time += delta
        _treshold_time += delta

        if _acc_time > duration:
            reset()
            return

func reset():
    stop()
    running = false
    _sync_stream.set_sync_stream_volume(0,0)
    _sync_stream.set_sync_stream_volume(1,-60)

func _play_next_sound():
    _sync_stream.set_sync_stream_volume(0,-60)
    _sync_stream.set_sync_stream_volume(1,0)

func _on_treshold_timer_timeout() -> void:
    _play_next_sound()
