@tool
extends Node2D

@export_range(0,1,0.01) var progress_percent : float = 0:
    set(value):
        progress_percent = value
        queue_redraw()

@export var radius : float = 10:
    set(value):
        radius = value
        queue_redraw()

@export var width : float = 10:
    set(value):
        width = value
        queue_redraw()

@export var color_overrides : Dictionary[float,Color]

var duration : float = 0
var _acc_time : float = 0
var running : bool = false

func start(time : float):
    if time <= 0:
        push_error("Trying to start a progress bar 2D with a time of %f (must be higher than 0)")
        return

    # if running:
    #     return

    progress_percent = 0
    duration = time
    _acc_time = 0
    running = true

func _process(delta):
    if not running:
        return

    _acc_time += delta
    if _acc_time > duration:
        stop()
    queue_redraw()    

func stop():
    running = false
    progress_percent = 0
    _acc_time = 0

func _draw() -> void:
    var progress = progress_percent
    if running:
        progress = _acc_time / duration

    var color = Color.WHITE
    for key in color_overrides.keys():
        if key < progress:
            color = color_overrides[key]
    
    draw_arc(Vector2.ZERO,radius,0,progress * 2 * PI,20,color,width)