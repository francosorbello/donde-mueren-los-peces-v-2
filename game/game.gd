extends Control

signal level_loaded

@export var level_data : LevelDataResource
@export var initial_level_name : String
var current_level : Node

func _ready():
	GlobalSignal.level_change_requested.connect(_on_request_level_change)
	
	if initial_level_name and level_data.levels.has(initial_level_name):
		load_level_scene(level_data.levels[initial_level_name])

	Console.add_command("clear_save",clear_save)
	Console.add_command("dump_save",dump_save)
	Console.font_size = 30

func _on_request_level_change(lvl_name : String):
	if level_data.levels.has(lvl_name):
		load_level_scene(level_data.levels[lvl_name])

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
	
	level_loaded.emit()

	
func clear_save():
	var current_save = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	if current_save:
		current_save.clear_save()
		Console.print_line("Save cleared")

func dump_save():
	var current_save = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	if current_save:
		var save_copy = current_save.duplicate()
	# var save_name = "save_%d"%randi_range(1,1000)
		var save_name = save_copy.filename
		var save_path = "res://tests/save_dumps/%s.res"%save_name
		var result = ResourceSaver.save(save_copy,save_path)
		if result == OK:
			Console.print_line("Dumped save %s to path %s"%[save_name,save_path])
		else:
			Console.print_error("Could not dump save")
