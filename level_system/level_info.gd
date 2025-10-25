@tool
extends Node
class_name LevelInfo

@export var level_name : String
@export var id : String
@export_tool_button("Generate ID") var generate_id_action = generate_id

@export_category("Spawn positions")
@export var coming_from_up : Marker2D
@export var coming_from_down: Marker2D
@export var coming_from_left: Marker2D
@export var coming_from_right: Marker2D

func _ready():
    if Engine.is_editor_hint():
        add_to_group("level_info",true)
        return

    save_to_file()
    GlobalSignal.level_entered.emit(level_name)

func generate_id():
    id = UUIDGenerator.generate_uuid()

func save_to_file():
    var save_file = IndieBlueprintSaveManager.current_saved_game as ASavedGame
    if save_file:
        save_file.add_visited_level(level_name)

func get_spawn_marker(for_direction : Vector2) -> Marker2D:
    match for_direction:
        Vector2.LEFT:
            return coming_from_left
        Vector2.RIGHT:
            return coming_from_right
        Vector2.UP:
            return coming_from_up
        Vector2.DOWN:
            return coming_from_down

    return null