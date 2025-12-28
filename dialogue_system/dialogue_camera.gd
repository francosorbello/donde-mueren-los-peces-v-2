extends Camera2D
class_name DialogueCamera

const SCREEN_CENTER = Vector2(288,270)/2

var _target : Node2D
var _dialogue : DialogueResource

@onready var _target_follow_component_scene = preload("res://inventory_system/carryable_item/target_follow_component.tscn")

var _target_follow_component
var _fake_center_target : Node2D

func _init(target : Node2D, dialogue) -> void:
	_target = target
	_dialogue = dialogue

func _ready():
	_fake_center_target = Node2D.new()
	_fake_center_target.top_level = true
	_fake_center_target.global_position = SCREEN_CENTER

	global_position = SCREEN_CENTER
	_target_follow_component = _target_follow_component_scene.instantiate()
	_target_follow_component.target = _target
	add_child(_target_follow_component)

	DialogueManager.dialogue_ended.connect(func(dialogue):
		if dialogue == _dialogue:
			_handle_destroy()
	)

func _handle_destroy():
	var fade_rect = GlobalData.main_screen_manager.get_fade_rect()
	var fade_in = fade_rect.fade_in()
	await fade_in.finished
	queue_free()
	fade_rect.fade_out()
