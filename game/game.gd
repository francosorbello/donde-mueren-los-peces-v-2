extends Control

signal level_loaded

var level_data: LevelDataResource
@export var initial_level_name: StringResource
var current_level: Node

var last_transition_direction: Vector2

var _transition_ui: Control
var _ignore_fade_in: bool = false

func _ready():
	_transition_ui = $UI/TransitionColor
	_set_transition_shader_progress(1)
	_set_spotlight_transition_progress(0)
	_ignore_fade_in = true

	level_data = GlobalData.level_data
	GlobalSignal.level_change_requested.connect(_on_request_level_change)
	
	if initial_level_name and (not initial_level_name.value.is_empty()):
		# load_level_scene(level_data.levels[initial_level_name])
		_on_request_level_change(initial_level_name.value, {"direction": Vector2.ZERO})

	# OxygenManager.start_depletion()

func _on_request_level_change(lvl_name: String, extra_data : Dictionary):
	if level_data.levels.has(lvl_name):
		print("Loading level %s with direction %s" % [lvl_name, extra_data.direction])
		last_transition_direction = extra_data.direction
		load_level_scene(level_data.levels[lvl_name], extra_data)
	else:
		push_error("Level %s is not on level data"%lvl_name)

func _clear_previous_level():
	if not current_level:
		return
	# %GameViewport.remove_child.call_deferred(current_level)
	current_level.queue_free()

func load_level_scene(level_scene: PackedScene, extra_data : Dictionary = {}):
	var transition := _fade_to_player(0.0)
	await transition.finished
	_clear_previous_level()

	var level_instance = level_scene.instantiate()
	%GameViewport.add_child.call_deferred(level_instance)
	current_level = level_instance

	var player_spawner = current_level.find_child("PlayerSpawner")
	if player_spawner:
		if extra_data.has("override_position") and extra_data["override_position"] != Vector2.ZERO:
			player_spawner.call_deferred("spawn_player_on_pos", extra_data["override_position"])
		else:
			player_spawner.call_deferred("spawn_player", extra_data["direction"])
	transition = _fade_to_player(2.0)
	await transition.finished
	level_loaded.emit()


func _fade_to_player(final_value: float) -> Tween:
	var tween := create_tween()

	var spotlight_pos: Vector2 = Vector2(.5, .5)

	var player = get_tree().get_first_node_in_group("player") as APlayer
	if player:
		spotlight_pos = _get_screen_position_for(player,%GameViewport) / Vector2(1920,1080)
		
		
	var mat: ShaderMaterial = $UI/SpotlightTransition.material
	mat.set_shader_parameter("circle_position", spotlight_pos)

	var initial_value: float = mat.get_shader_parameter("circle_size")

	tween.tween_method(_set_spotlight_transition_progress, initial_value, final_value, 0.5)

	return tween

func _set_spotlight_transition_progress(value: float):
	$UI/SpotlightTransition.material.set_shader_parameter("circle_size", value)

func _start_fade_in() -> Tween:
	var tween := self.create_tween()

	tween.set_ease(Tween.EASE_IN)
	var initial_value: float = _transition_ui.modulate.a
	tween.tween_method(_set_transition_shader_progress, initial_value, 1.0, 0.5)
	return tween

func _start_fade_out():
	var tween := create_tween()
	tween.tween_method(_set_transition_shader_progress, 1.0, 0.0, 0.5)

	return tween

func _set_transition_shader_progress(value: float):
	_transition_ui.modulate = Color(1, 1, 1, value)


func _get_screen_position_for(node: Node2D, subviewport: SubViewport) -> Vector2:
	# Get the node's position in the SubViewport
	var viewport_pos = node.get_global_transform_with_canvas().origin
	
	# Get the SubViewportContainer (parent of SubViewport)
	var container = subviewport.get_parent()
	
	if container is SubViewportContainer:
		# Get the container's global position on screen
		var container_global_pos = container.get_global_transform_with_canvas().origin
		
		# Account for SubViewport stretch/scaling if any
		var stretch_factor = container.size / Vector2(subviewport.size_2d_override)
		
		# Calculate final screen position
		var screen_pos = container_global_pos + (viewport_pos * stretch_factor)
		return screen_pos
	else:
		# If not using SubViewportContainer, you'll need to handle differently
		# based on how you're displaying the SubViewport
		return viewport_pos
