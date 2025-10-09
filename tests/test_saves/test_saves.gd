extends Control

func _ready() -> void:
	IndieBlueprintSaveManager.loaded_savegame.connect(_on_game_loaded)
	IndieBlueprintSaveManager.updated_savegame.connect(_on_game_loaded)

func _on_game_loaded(game : TestSavedGame):
	$ValueLabel.text = "Current value: %d"%game.test_value

func _on_save_button_pressed() -> void:
	if IndieBlueprintSaveManager.save_filename_exists("test"):
		var save = IndieBlueprintSaveManager.load_savegame("test")
		IndieBlueprintSaveManager.make_current(save)
		return

	var new_save = TestSavedGame.new()

	new_save.write_savegame("test")
	IndieBlueprintSaveManager.make_current(new_save)


func _on_increment_button_pressed() -> void:
	var saved_game = IndieBlueprintSaveManager.current_saved_game as TestSavedGame
	
	saved_game.test_value += 1
	saved_game.write_savegame()
