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
	var transition := _start_fade_in()
	_clear_previous_level()

	await transition.finished

	var level_instance = level_scene.instantiate()
	%GameViewport.add_child.call_deferred(level_instance)
	current_level = level_instance

	var player_spawner = current_level.find_child("PlayerSpawner")
	if player_spawner:
		player_spawner.call_deferred("spawn_player",last_transition_direction)
	transition = _start_fade_out()	
	await transition.finished
	level_loaded.emit()
	
func _start_fade_in() -> Tween:
	var tween := create_tween()

	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(_set_transition_shader_progress,0.0,1.0,0.5)
	return tween

func _start_fade_out():
	var tween := create_tween()
	tween.tween_method(_set_transition_shader_progress,1.0,0.0,0.5)

	return tween

func _set_transition_shader_progress(value : float):
	$UI/TransitionColor.modulate = Color(1,1,1,value)