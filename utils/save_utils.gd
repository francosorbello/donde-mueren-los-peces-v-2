extends Object
class_name SaveUtils

static func get_save() -> ASavedGame:
    var saved_game = IndieBlueprintSaveManager.current_saved_game
    if saved_game and saved_game is ASavedGame:
        return saved_game
    
    return null