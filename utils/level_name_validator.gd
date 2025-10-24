extends Node

var lvl_data : LevelDataResource

func _ready() -> void:
	if not OS.has_feature("debug"):
		return
	
	lvl_data = GlobalData.level_data
	if get_parent().get("next_level_id") != null:
		var level_name = get_parent().next_level_id as String
		var msg = ""
		if level_name.is_empty():
			msg = "(%s) next_level_id is empty. Transitions wont work"%get_parent()
		elif not lvl_data.levels.has(level_name):
			msg = "(%s) Level %s doesnt exist"%[get_parent(),level_name]

		if not msg.is_empty():
			print_error_message(msg)

func print_error_message(msg : String):
	Console.print_error(msg)
	push_error(msg)