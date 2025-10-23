extends Node

@export_dir var abilities_directory : String

var abilities : Array[AnItem]

func _ready() -> void:
    Console.add_command("clear_save",clear_save)
    Console.add_command("dump_save",dump_save)
    Console.add_command("unlock_all_abilities",unlock_all_abilities)
    Console.font_size = 30

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

func unlock_all_abilities():
    if abilities.is_empty():
        _load_all_abilities()
    var player = get_tree().get_first_node_in_group("player")
    print(player != null)
    if player:
        player.abilities = abilities

func _load_all_abilities():
    for ability_file_name in DirAccess.get_files_at(abilities_directory):
        var ability = ResourceLoader.load(abilities_directory+"/"+ability_file_name) as AnItem
        print(ability_file_name, ability)
        if ability:
            abilities.append(ability)
    pass