extends Control

@onready var label = $Label

var secs : float
var mins : float

var started : bool = false

func _ready() -> void:
    start()

func start():
    secs = 0
    mins = 0
    started = true

func _process(delta):
    if started:
        secs += delta
        if secs > 60:
            mins += 1
            secs = 0
    
        label.text = "%.0fm:%.2fs"%[mins,secs]