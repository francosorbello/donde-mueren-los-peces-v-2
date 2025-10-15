@tool
extends Node
class_name LevelInfo

@export var level_name : String
@export var id : String
@export_tool_button("Generate ID") var generate_id_action = generate_id

func _ready():
    if Engine.is_editor_hint():
        return

    save_to_file()
    GlobalSignal.level_entered.emit(id)

func generate_id():
    id = UUIDGenerator.generate_uuid()

func save_to_file():
    var save_file = IndieBlueprintSaveManager.current_saved_game as ASavedGame
    if save_file:
        save_file.add_visited_level(id)