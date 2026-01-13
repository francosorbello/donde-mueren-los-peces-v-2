extends Node
## system similar to the global event system, but using godot signals instead
## Usage:
## 1. Add your signal here. Then, 
##  you can call GlobalSignal.signal_name.connect() to connect to it
##  you can call GlobalSignal.signal_name.emit() to emit it

signal level_change_requested(level_name : String, extra_data : Dictionary)
signal event_set(ev : PersistentEvent, cached_events : Dictionary[String,float])
signal level_entered(data : Dictionary)
signal game_ui_opened()
signal game_ui_closed()
signal temp_event_set(ev : PersistentEvent)
signal temp_event_removed(event_name : String)
signal on_dialogue_event(event_name : String)

signal game_pause_toggled(is_paused : bool)

## Player
signal jump_started()
signal jump_finished()
signal dash_started()

## Interactables
signal interactable_found()
signal interactable_lost()