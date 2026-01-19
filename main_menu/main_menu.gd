extends Control

@export var kiosk_mode : bool = false
@export var initial_level : StringResource

@export_category("Forced save")
@export var forced_save : ASavedGame

func _ready():
	Console.add_command("force_kiosk_mode",func():
		kiosk_mode = true
	)

	Console.add_command("fresh_start",func():
		_on_reset_save_button_pressed()
		initial_level.value = "lvl_vs_n_room_1"
		_on_start_button_pressed()
	)

	if OS.is_debug_build() and not OS.has_feature("editor"):
		$DebugBuildLabel.show()
		kiosk_mode = true

	$VBoxContainer/StartButton.grab_focus()
	if kiosk_mode or OS.has_feature("release"):
		$VBoxContainer/ResetSaveButton.visible = false
	_start_menu_music()

func _on_start_button_pressed() -> void:
	CommonSfxPlayer.play_sound("start_game",false)

	if kiosk_mode or OS.has_feature("release"):
		do_kiosk_mode()
		return

	if forced_save:
		do_forced_save()
		return

	if IndieBlueprintSaveManager.save_filename_exists("main_save"):
		var saved_game = IndieBlueprintSaveManager.load_savegame("main_save")
		if saved_game is not ASavedGame:
			print("Test is not a ASavedGame instance. Delete it and create it again")
			IndieBlueprintSaveManager.remove("main_svae")
			create_test_game()
		else:
			IndieBlueprintSaveManager.make_current(saved_game)
			print("Loaded test savegame")
	else:
		create_test_game()

	get_parent().start_game_intro()
	pass # Replace with function body.

func do_forced_save():
	var new_game = forced_save.duplicate()
	new_game.write_savegame("forced_save")
	IndieBlueprintSaveManager.make_current(new_game)
	get_parent().start_game()

func create_test_game():
	var new_game = ASavedGame.new()
	new_game.write_savegame("main_save")
	IndieBlueprintSaveManager.make_current(new_game)
	print("Created test savegame")

func do_kiosk_mode():
	if IndieBlueprintSaveManager.save_filename_exists("main_save"):
		_on_reset_save_button_pressed()
		var save_game = IndieBlueprintSaveManager.load_savegame("main_save") as ASavedGame
		IndieBlueprintSaveManager.make_current(save_game)
	else:
		create_test_game()
	initial_level.value = "lvl_vs_n_room_1"
	# prints(initial_level,initial_level.resource_path)
	# ResourceSaver.save(initial_level,initial_level.resource_path)

	get_parent().start_game_intro()

func _start_menu_music():
	var tween := create_tween()
	tween.tween_property($MenuMusic,"volume_db",0,0.2)

func _on_reset_save_button_pressed() -> void:
	var save_game = IndieBlueprintSaveManager.load_savegame("main_save") as ASavedGame
	if save_game:
		save_game.clear_save()
		print("Reset save done")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_options_pressed() -> void:
	$SettingsMenu.show()
	pass # Replace with function body.
