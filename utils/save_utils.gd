extends Object
class_name SaveUtils

static func get_save() -> ASavedGame:
    var saved_game = IndieBlueprintSaveManager.current_saved_game
    if saved_game and saved_game is ASavedGame:
        return saved_game
    
    return null

static func scene_path_to_name(path : String):
    var sliced_path = path.split("/")
    var file_name_tscn = sliced_path[sliced_path.size()-1]
    var name_only = file_name_tscn.get_slice(".tscn",0)
    return name_only     