extends Node

@export_dir var abilities_directory : String

var abilities : Array[AnItem]

func _ready() -> void:
    Console.add_command("clear_save",clear_save)
    Console.add_command("dump_save",dump_save)
    Console.add_command("unlock_all_abilities",unlock_all_abilities,["is_permanent"],1)
    Console.add_command("restart_level",restart_level)
    
    Console.font_size = 30

func dump_blackboard():
    var blackboard : GameBlackboard = get_tree().get_first_node_in_group("blackboard")
    if blackboard:
        print(blackboard.temp_events)

func restart_level():
    var level_node = get_parent().current_level as Node
    if level_node:
        GlobalSignal.level_change_requested.emit(SaveUtils.scene_path_to_name(level_node.scene_file_path),get_parent().last_transition_direction)

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

func unlock_all_abilities(is_permanent : String):
    if abilities.is_empty():
        _load_all_abilities()
    var player = get_tree().get_first_node_in_group("player")
    if player:
        player.abilities = abilities
    
    if is_permanent == "true":
        var save_game = SaveUtils.get_save()
        if save_game:
            save_game.unlocked_abilities = abilities 


func _load_all_abilities():
    for ability_file_name in DirAccess.get_files_at(abilities_directory):
        var ability = ResourceLoader.load(abilities_directory+"/"+ability_file_name) as AnItem
        if ability:
            abilities.append(ability)
    pass