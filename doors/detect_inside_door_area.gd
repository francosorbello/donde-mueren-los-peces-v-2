extends Area2D

var running : bool = false

func start():
    running = true
    _player = null
    
    $RunningTimer.start()

var _player : APlayer

func _process(_delta):
    if running:
        var bodies = get_overlapping_bodies()
        for body in bodies:
            if body is APlayer:
                _player = body
                return
        _player = null

func _on_running_timer_timeout() -> void:
    running = false
    if _player:
        _player.die()
    
    _player = null
