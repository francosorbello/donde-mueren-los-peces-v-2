@tool
extends EditorScript
class_name AddLevelToDatabase

var db_path = "res://level_system/level_data_res.tres"

func _run() -> void:
    var db_instance = ResourceLoader.load(db_path) as LevelDataResource

    var level_scene = ResourceLoader.load(get_scene().scene_file_path) as PackedScene
    var level_name = SaveUtils.scene_path_to_name(get_scene().scene_file_path)
    
    print("Setting %s to packed scene %s"%[level_name,level_scene])
    db_instance.levels.set(level_name,level_scene)

    ResourceSaver.save(db_instance)

