extends Control

@export var dialogue : DialogueResource
@export var balloon_scene : PackedScene

func _ready():
	await get_tree().create_timer(2).timeout
	_start_menu_music()
	_fade_out()
	await get_tree().create_timer(2).timeout
	DialogueManager.show_dialogue_balloon_scene(balloon_scene,dialogue,"start")
	DialogueManager.dialogue_ended.connect(func(_dial):
		if _dial == dialogue:
			GlobalData.main_screen_manager.start_game()
	)

func _start_menu_music():
	var tween := create_tween()
	tween.tween_property($AudioStreamPlayer,"volume_db",0,0.2)

func _fade_out():
	var tween := create_tween()
	tween.tween_property($ColorRect2,"color:a",0,1)