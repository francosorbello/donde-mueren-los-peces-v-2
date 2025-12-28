extends Camera2D
class_name DialogueCamera

const SCREEN_CENTER = Vector2(290,270)/2

var _target : Node2D
var _dialogue : DialogueResource

var _fake_center_target : Node2D

var _moving_tween : Tween

func _init(target : Node2D, dialogue) -> void:
	_target = target
	_dialogue = dialogue

func _ready():
	_fake_center_target = Node2D.new()
	_fake_center_target.top_level = true
	_fake_center_target.global_position = SCREEN_CENTER

	global_position = SCREEN_CENTER
	_tween_to_pos(_target.global_position)

	DialogueManager.dialogue_ended.connect(func(dialogue):
		if dialogue == _dialogue:
			_handle_destroy()
	)

func _handle_destroy():
	# _target_follow_component.target = _fake_center_target
	var tween = _tween_to_pos(SCREEN_CENTER)
	tween.tween_callback(func():
		queue_free()
	)

func _tween_to_pos(pos : Vector2) -> Tween:
	if _moving_tween and _moving_tween.is_running():
		_moving_tween.kill()

	_moving_tween = create_tween()
	
	_moving_tween.set_trans(Tween.TRANS_SINE)
	_moving_tween.tween_property(self,"global_position",pos,0.5)

	return _moving_tween