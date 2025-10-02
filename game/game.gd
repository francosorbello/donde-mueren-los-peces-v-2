extends Control

signal level_loaded

func load_level_scene(level_scene : PackedScene):
    var level_instance = level_scene.instantiate()
    %GameViewport.add_child(level_instance)
    level_loaded.emit()