extends Control

@export var kiosk_mode : bool = false
@export var initial_level : StringResource

func _ready():
	if OS.is_debug_build() and not OS.has_feature("editor"):
		$DebugBuildLabel.show()
		kiosk_mode = true

	$VBoxContainer/StartButton.grab_focus()
	if kiosk_mode:
		$VBoxContainer/ResetSaveButton.visible = false
	_start_menu_music()

func _on_start_button_pressed() -> void:
	if kiosk_mode:
		do_kiosk_mode()
		return

	if IndieBlueprintSaveManager.save_filename_exists("test"):
		var saved_game = IndieBlueprintSaveManager.load_savegame("test")
		if saved_game is not ASavedGame:
			print("Test is not a ASavedGame instance. Delete it and create it again")
			IndieBlueprintSaveManager.remove("test")
			create_test_game()
		else:
			IndieBlueprintSaveManager.make_current(saved_game)
			print("Loaded test savegame")
	else:
		create_test_game()

	get_parent().start_game()
	pass # Replace with function body.

func create_test_game():
	var new_game = ASavedGame.new()
	new_game.write_savegame("test")
	IndieBlueprintSaveManager.make_current(new_game)
	print("Created test savegame")

func do_kiosk_mode():
	if IndieBlueprintSaveManager.save_filename_exists("test"):
		_on_reset_save_button_pressed()
		var save_game = IndieBlueprintSaveManager.load_savegame("test") as ASavedGame
		IndieBlueprintSaveManager.make_current(save_game)
	else:
		create_test_game()
	initial_level.value = "lvl_vs_room_1"
	ResourceSaver.save(initial_level,initial_level.resource_path)

	get_parent().start_game()

func _start_menu_music():
	var tween := create_tween()
	tween.tween_property($MenuMusic,"volume_db",0,0.2)

func _on_reset_save_button_pressed() -> void:
	var save_game = IndieBlueprintSaveManager.load_savegame("test") as ASavedGame
	if save_game:
		save_game.clear_save()
		print("Reset save done")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
