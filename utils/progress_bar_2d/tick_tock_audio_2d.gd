extends AudioStreamPlayer2D

@export var sounds : Array[AudioStream]

var duration : float
var running : bool = false

var _acc_time : float
var _treshold : float
var _current_index : int
var _treshold_time : float

func start(time : float):
    duration = time
    running = true

    _acc_time = 0
    _current_index = 0

    _treshold = duration / sounds.size()

    # print("Playing %d sounds for %s seconds. Each sound lasts %f seconds"%[sounds.size(),duration,_treshold])
    stream = sounds[0]
    play()

func _process(delta: float) -> void:
    if running:
        _acc_time += delta
        _treshold_time += delta

        if _acc_time > duration:
            stop()
            running = false
            return
        
        if _treshold_time > _treshold:
            _treshold_time = 0
            _play_next_sound()

func _play_next_sound():
    _current_index += 1
    if _current_index >= sounds.size():
        return
    stream = sounds[_current_index]
    play()