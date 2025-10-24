@tool
extends EditorScript
class_name RunCurrentLevel

var initial_level_res_path : String = "res://utils/level_related/initial_level_res.tres"


func _run() -> void:
    _set_current_level_as_initial_level()
    EditorInterface.play_main_scene()


func _set_current_level_as_initial_level():
    var initial_level_res = ResourceLoader.load(initial_level_res_path) as StringResource
    if initial_level_res:
        var level_name = SaveUtils.scene_path_to_name(get_scene().scene_file_path)
        initial_level_res.value = level_name
        ResourceSaver.save(initial_level_res)
    
