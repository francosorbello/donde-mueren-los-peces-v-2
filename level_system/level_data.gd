@tool
extends Resource
class_name LevelDataResource

@export var levels : Dictionary[String, PackedScene]

@export_category("Import helper")
@export var scene_to_import : PackedScene
@export_tool_button("Import") var import_action = _import

func _import():
    if scene_to_import:
        var file_name = path_to_name(scene_to_import.resource_path)
        levels.set(file_name,scene_to_import)
        ResourceSaver.save(self,self.resource_path)
        scene_to_import = null

func path_to_name(path : String):
    var sliced_path = path.split("/")
    var file_name_tscn = sliced_path[sliced_path.size()-1]
    var name_only = file_name_tscn.get_slice(".tscn",0)
    return name_only 