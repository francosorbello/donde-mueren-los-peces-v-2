extends Node
## system similar to the global event system, but using godot signals instead
## Usage:
## 1. Add your signal here. Then, 
##  you can call GlobalSignal.signal_name.connect() to connect to it
##  you can call GlobalSignal.signal_name.emit() to emit it

signal level_change_requested(level_name : String, direction : Vector2)
signal event_set(ev : PersistentEvent, cached_events : Dictionary[String,float])
signal level_entered(level_id : String)
signal game_ui_opened()
signal game_ui_closed()