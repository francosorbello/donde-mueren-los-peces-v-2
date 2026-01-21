@tool
extends Node

@export var level_name : String
@export_tool_button("Set level name") var set_level_name_action = _set_name
@export_tool_button("Set level name from scene path") var set_name_from_path_action = _set_name_from_file
@export_tool_button("Set and add to database") var set_and_add_to_db_action = _set_and_add_to_db

func _set_name_from_file():
    level_name = SaveUtils.scene_path_to_name(owner.scene_file_path) 
    _set_name()

func _set_name():

    if level_name.is_empty():
        return

    var scene_root = owner
    scene_root.name = level_name
    var level_info : LevelInfo = scene_root.find_child("LevelInfo")
    if level_info:
        level_info.level_name = level_name

func _set_and_add_to_db():
    _set_name_from_file()
    # if Engine.is_editor_hint():
    #     var add_to_db = AddLevelToDatabase.new()
    #     add_to_db._run()