@tool
extends Node
class_name LevelInfo

@export var level_name : String
@export var id : String
@export_tool_button("Generate ID") var generate_id_action = generate_id

@export_category("Spawn positions")
@export var up_position : Marker2D
@export var down_position: Marker2D
@export var left_position: Marker2D
@export var right_position: Marker2D

func _ready():
    if Engine.is_editor_hint():
        add_to_group("level_info",true)
        return

    save_to_file()
    GlobalSignal.level_entered.emit(id)

func generate_id():
    id = UUIDGenerator.generate_uuid()

func save_to_file():
    var save_file = IndieBlueprintSaveManager.current_saved_game as ASavedGame
    if save_file:
        save_file.add_visited_level(id)

func get_spawn_marker(for_direction : Vector2) -> Marker2D:
    match for_direction:
        Vector2.LEFT:
            return left_position
        Vector2.RIGHT:
            return right_position
        Vector2.UP:
            return up_position
        Vector2.DOWN:
            return down_position

    return null