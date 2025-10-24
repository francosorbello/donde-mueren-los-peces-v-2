@tool
extends Node

@export var level_name : String
@export_tool_button("Set level name") var set_level_name_action = _set_name

func _set_name():
    var scene_root = get_tree().root
    scene_root.name = level_name
    var level_info : LevelInfo = scene_root.find_child("LevelInfo")
    if level_info:
        level_info.level_name = level_name