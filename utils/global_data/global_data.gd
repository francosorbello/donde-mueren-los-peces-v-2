extends Node

@export var level_data : LevelDataResource
@export var area_bg_colors : Dictionary[LevelInfo.GameAreaType,Color]
@export var area_palettes : Dictionary[LevelInfo.GameAreaType,Texture2D]
@export var dialogue_balloon : PackedScene

var main_screen_manager : MainScreenManager

func start_dialogue(dialogue : DialogueResource, start_node : String = "start"):
    DialogueManager.show_dialogue_balloon_scene(dialogue_balloon,dialogue,start_node)