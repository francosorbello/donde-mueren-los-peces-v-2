extends Node
class_name MainScreenManager
## Main scene of the executable.
## The game is separated in a series of main screens, like the menu or the game itself

@export var screens : Dictionary[String,PackedScene]

var current_screen : Node

func _ready():
	GlobalData.main_screen_manager = self
	
	$OutroCanvasLayer/FadeRect.color.a = 0
	
	if OS.is_debug_build() and not OS.has_feature("editor"):
		start_intro_screen()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		start_main_menu()
	
	Console.add_command("set_lang",set_lang,["lang_name"],1)
	set_lang("es")

func set_lang(lang_name : String):
	TranslationServer.set_locale(lang_name)

func transition_to(screen : String):
	assert(screens.has(screen),"No screen named %s"%screen)

	# fade in
	var fade_in : Tween = $CanvasLayer/FadeRect.fade_in()
	await fade_in.finished
	
	# clear and instance new screen
	_clear()
	var scene_instance = screens[screen].instantiate()
	add_child(scene_instance)
	current_screen = scene_instance

	$CanvasLayer/FadeRect.fade_out()

func _clear():
	if current_screen:
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
	transition_to("Game")

func start_game_intro():
	if OS.has_feature("release"):
		transition_to("GameIntro")
	else:
		start_game()

func start_main_menu():
	transition_to("MainMenu")

func start_intro_screen():
	transition_to("IntroScreen")

func get_fade_rect() -> Node2D:
	return $CanvasLayer/FadeRect

func get_outro_fade_rect() -> Node2D:
	return $OutroCanvasLayer/FadeRect
