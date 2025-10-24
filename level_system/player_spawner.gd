extends Node

@export var player_scene : PackedScene
@export var level_info : LevelInfo
@export var default_spawn_pos : PlayerSpawnPoint
@export_category("Camera")
@export var attach_camera : bool = false

func _ready() -> void:
    pass

func spawn_player(direction : Vector2):
    var player = player_scene.instantiate() as APlayer
    var spawn_marker = level_info.get_spawn_marker(direction)
    if not spawn_marker:
        spawn_marker = default_spawn_pos

    player.global_position = spawn_marker.global_position
    get_parent().add_child(player)
    if attach_camera:
        var camera = Camera2D.new()
        player.add_child(camera)

