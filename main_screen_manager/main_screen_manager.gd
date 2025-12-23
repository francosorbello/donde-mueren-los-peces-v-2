extends Node
class_name MainScreenManager
## Autoload that handles main screen
## The game is separated in a series of screens, like the menu or the game itself

@export var screens : Dictionary[String,PackedScene]

var current_screen : Node

func _ready():
    if OS.is_debug_build() and not OS.has_feature("editor"):
        start_intro_screen()
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
    else:
        start_main_menu()
    GlobalSignal.on_request_main_scene_change.connect(_main_scene_change_requested)


func _main_scene_change_requested(new_scene : String):    
    if screens.has(new_scene):
        _start_scene.call_deferred(screens[new_scene])
    else:
        push_error("No screen named %s"%new_scene)

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
    _start_scene(screens["Game"])

func start_main_menu():
    _start_scene(screens["MainMenu"])

func start_intro_screen():
    _start_scene(screens["IntroScreen"])

func _start_scene(scene : PackedScene):
    _clear()

    var scene_instance = scene.instantiate()
    add_child(scene_instance)

    current_screen = scene_instance