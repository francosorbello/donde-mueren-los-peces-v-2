@tool
extends Sprite2D

@export var rotation_speed : float = 100
@export var chopped : bool = false
@export var chopped_duration : float = 0.2

var _chopped_current_duration : float = 0

func _process(delta):
    if chopped:
        _chopped_current_duration += delta
        if _chopped_current_duration > chopped_duration:
            rotation += _chopped_current_duration * rotation_speed
            _chopped_current_duration = 0
    else:
        rotation += delta * rotation_speed
    
    if rotation > 2 * PI:
        rotation = 0