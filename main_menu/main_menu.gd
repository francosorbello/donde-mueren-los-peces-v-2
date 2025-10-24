extends Control

func _on_start_button_pressed() -> void:
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


func _on_reset_save_button_pressed() -> void:
    var save_game = IndieBlueprintSaveManager.load_savegame("test") as ASavedGame
    if save_game:
        save_game.clear_save()
        print("Reset save done")
