extends Control

signal level_loaded

var level_data : LevelDataResource
@export var initial_level_name : StringResource
var current_level : Node

var last_transition_direction : Vector2

func _ready():
	level_data = GlobalData.level_data
	GlobalSignal.level_change_requested.connect(_on_request_level_change)
	
	if initial_level_name and (not initial_level_name.value.is_empty()):
		# load_level_scene(level_data.levels[initial_level_name])
		_on_request_level_change(initial_level_name.value,Vector2.ZERO)

	OxygenManager.start_depletion()

func _on_request_level_change(lvl_name : String, direction = Vector2.ZERO):
	if level_data.levels.has(lvl_name):
		print("Loading level %s with direction %s"%[lvl_name,direction])
		last_transition_direction = direction
		load_level_scene(level_data.levels[lvl_name])
	else:
		push_error("Level %s is not on level data"%lvl_name)

func _clear_previous_level():
	if not current_level:
		return
	%GameViewport.remove_child.call_deferred(current_level)
	current_level.queue_free()

func load_level_scene(level_scene : PackedScene):
	_clear_previous_level()

	var level_instance = level_scene.instantiate()
	%GameViewport.add_child.call_deferred(level_instance)
	
	current_level = level_instance
	var player_spawner = current_level.find_child("PlayerSpawner")
	if player_spawner:
		player_spawner.call_deferred("spawn_player",last_transition_direction)
	level_loaded.emit()
	
