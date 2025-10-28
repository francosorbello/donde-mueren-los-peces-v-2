extends Node

@export var player_scene : PackedScene
@export var level_info : LevelInfo
@export var default_spawn_pos : PlayerSpawnPoint
@export_category("Camera")
@export var attach_camera : bool = false
@export var camera_to_attach : Camera2D

signal player_spawned(player : APlayer)

func spawn_player(direction : Vector2):
    var player = player_scene.instantiate() as APlayer
    var spawn_marker = level_info.get_spawn_marker(direction)
    if not spawn_marker:
        spawn_marker = default_spawn_pos

    player.global_position = spawn_marker.global_position
    get_parent().add_child(player)
    if attach_camera:
        if not camera_to_attach:
            var camera = Camera2D.new()
            player.add_child(camera)
        else:
            camera_to_attach.get_parent().remove_child(camera_to_attach)
            player.add_child(camera_to_attach)

    player_spawned.emit(player)




