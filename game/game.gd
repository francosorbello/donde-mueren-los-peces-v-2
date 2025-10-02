extends Control

signal level_loaded

@export var levels : Dictionary[String, PackedScene]

var current_level : Node

func _ready():
    GlobalSignal.level_change_requested.connect(_on_request_level_change)
    load_level_scene(levels["level1"])
    pass

func _on_request_level_change(lvl_name : String):
    if levels.has(lvl_name):
        load_level_scene(levels[lvl_name])

func _clear_previous_level():
    if not current_level:
        return
    %GameViewport.remove_child(current_level)
    current_level.queue_free()

func load_level_scene(level_scene : PackedScene):
    _clear_previous_level()

    var level_instance = level_scene.instantiate()
    %GameViewport.add_child(level_instance)
    
    current_level = level_instance
    
    level_loaded.emit()

