extends Camera2D
class_name DialogueCamera

const SCREEN_CENTER = Vector2(290,270)/2

var random_strenght : float = 1
var shake_strenght : float = 0
var shaking : bool = false

var _target : Node2D
var _dialogue : DialogueResource

var _moving_tween : Tween
var _zooming_tween : Tween

var keep_after_dialogue : bool = false

func _init(target : Node2D, dialogue) -> void:
	_target = target
	_dialogue = dialogue
	add_to_group("DialogueCamera")

func _ready():
	global_position = SCREEN_CENTER
	_tween_to_pos(_target.global_position)

	DialogueManager.dialogue_ended.connect(func(dialogue):
		if dialogue == _dialogue:
			_handle_destroy()
	)

func _handle_destroy():
	if keep_after_dialogue:
		return

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

func _tween_zoom_to(value : Vector2) -> Tween:
	if _zooming_tween and _zooming_tween.is_running():
		_zooming_tween.kill()

	_zooming_tween = create_tween()
	
	_zooming_tween.tween_property(self,"zoom",value,0.5)
	return _zooming_tween
	
func set_target(new_target):
	assert(new_target != null)

	_target = new_target
	_tween_to_pos(_target.global_position)

func _process(_delta: float) -> void:
	if not shaking:
		return
	offset = random_offset()
	
func random_offset():
	return Vector2(
		randf_range(-shake_strenght,shake_strenght),
		0,
		)

func start_shake():
	shake_strenght = random_strenght
	shaking = true

func stop_shake():
	var tween := create_tween()
	tween.tween_property(self,"shake_strenght",0,1)
	tween.tween_callback(func():
		shaking = false
	)

