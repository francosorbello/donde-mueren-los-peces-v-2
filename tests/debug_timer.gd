extends Control

@onready var label = $Label
@onready var room_label = $RoomLabel

var secs : float
var mins : float

var room_secs : float
var room_mins : float

var started : bool = false

func _ready() -> void:
    GlobalSignal.level_entered.connect(_on_room_entered)
    start()

func start():
    secs = 0
    mins = 0
    room_mins = 0
    room_secs = 0
    started = true

func _on_room_entered(_data):
    room_mins = 0
    room_secs = 0

func _process(delta):
    if started:
        secs += delta
        room_secs += delta
        if secs > 60:
            mins += 1
            secs = 0
        
        if room_secs > 60:
            room_mins += 1
            room_secs = 0
    
        label.text = "TOTAL: %.0fm:%.0fs"%[mins,secs]
        room_label.text = "ROOM: %.0fm:%.0fs"%[room_mins,room_secs]