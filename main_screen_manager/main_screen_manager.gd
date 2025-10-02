extends Node
## Autoload that handles main screen
## The game is separated in a series of screens, like the menu or the game itself

@export var main_menu_scene : PackedScene
@export var game_scene : PackedScene

var current_screen : Node

func _ready():
    start_main_menu()

func _clear():
    if current_screen:
        _clear_current()
    else:
        _clear_children()

func _clear_current():
    remove_child(current_screen)
    current_screen.queue_free()

func _clear_children():
    var prev_children = []
    for child in get_children():
        remove_child(child)
        prev_children.append(child)

    for child in prev_children:
        child.queue_free()

func start_game():
    _start_scene(game_scene)

func start_main_menu():
    _start_scene(main_menu_scene)

func _start_scene(scene : PackedScene):
    _clear()

    var scene_instance = scene.instantiate()
    add_child(scene_instance)

    current_screen = scene_instance