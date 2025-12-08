@tool
extends PathFollow2D

@export var speed : float = 50
@export var bounce_on_end : bool = false:
    set(value):
        bounce_on_end = value
@export_category("Running")
@export var start_on_ready : bool = true
@export var run_in_editor : bool = false
            

var running : bool = false
var speed_mod : int = 1
func _ready():
    if Engine.is_editor_hint():
        return

    running = start_on_ready
    progress = 0
    
func _process(delta):
    if running or run_in_editor:
        progress += delta * speed * speed_mod
        if bounce_on_end and (progress_ratio == 1 or progress_ratio == 0):
            speed_mod *= -1

func do_toggle():
    running = not running