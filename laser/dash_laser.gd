@tool
extends Node2D

enum LaserDirection {
	HORIZONTAL,
	VERTICAL
}
@export var direction : LaserDirection:
	set(value):
		direction = value
		if Engine.is_editor_hint():
			queue_redraw()
@export var end_point : float:
	set(value):
		end_point = value
		if Engine.is_editor_hint():
			queue_redraw()

@export var width : float = 1:
	set(value):
		width = value
		if Engine.is_editor_hint():
			queue_redraw()

@export var one_way_collision : bool = false

@export_category("Room actions")
@export var override_color : Color = Color.GREEN

@export_category("Timed")
@export var timed : bool = true
@export var timed_duration : float = 5.0
@export var timed_color_override : Color = Color.GRAY

@export_category("Sound")
@export var used_sound : AudioStream
@export var available_sound : AudioStream

var _room_actions : Array[RoomAction]
var _player : APlayer
var _player_died : bool = false
var _actions_disabled : bool = false

func _ready():
	if Engine.is_editor_hint():
		return

	for child in get_children():
		if child is RoomAction:
			_room_actions.append(child)
	setup()

func setup():
	var points = [
		_get_start_point(),
		_get_end_point()
	]

	$Line2D.points = points
	$Line2D.width = width
	if not _room_actions.is_empty():
		$Line2D.default_color = override_color

	var hurtbox_shape = RectangleShape2D.new()
	var detection_shape = RectangleShape2D.new()
	var size : Vector2
	if direction == LaserDirection.HORIZONTAL:
		size = Vector2(abs(end_point),width)
	else:
		size = Vector2(width, abs(end_point))
	
	hurtbox_shape.size = size
	if direction == LaserDirection.HORIZONTAL:
		hurtbox_shape.size.y -= 5
	else:
		hurtbox_shape.size.x -= 5
	$Hurtbox/CollisionShape2D.shape = hurtbox_shape
	$Hurtbox/CollisionShape2D.position = _get_end_point() / 2 + (_get_start_point() / 2)

	detection_shape.size = size
	$PlayerDetectionArea/CollisionShape2D.shape = detection_shape
	$PlayerDetectionArea/CollisionShape2D.position = _get_end_point() / 2 + (_get_start_point() / 2)
	$PlayerDetectionArea/CollisionShape2D.one_way_collision = one_way_collision


	$BoxParticles.position = _get_end_point() / 2 + (_get_start_point() / 2)
	$BoxParticles.emission_rect_extents = size / 2
	$BoxParticles.emitting = true

	$ProgressBar2D.position = _get_end_point() / 2 + (_get_start_point() / 2)

func use_actions():
	if _actions_disabled:
		return
	
	for child in _room_actions:
		child.use()

	if timed:
		_actions_disabled = true
	
func _get_start_point() -> Vector2:
	if direction == LaserDirection.HORIZONTAL:
		return Vector2(0,5.0)
	else:
		return Vector2(5.0,0)

func _get_end_point() -> Vector2:
	if direction == LaserDirection.HORIZONTAL:
		return Vector2(end_point,5.0)
	else:
		return Vector2(5.0,end_point)

func _draw() -> void:
	if _room_actions.is_empty():
		draw_circle(_get_start_point(),2,Color.WHITE)
		draw_circle(_get_end_point(),2,Color.WHITE)
	else:
		_draw_centered_box(5,_get_start_point())
		_draw_centered_box(5,_get_end_point())
	
	if Engine.is_editor_hint() and is_node_ready():
		var points = [
			_get_start_point(),
			_get_end_point()
		]
		$Line2D.points = points
		$Line2D.width = width


func _draw_centered_box(w : float, center : Vector2):
	var rect : Rect2
	rect.position = Vector2(center.x - w/2, center.y - w/2)
	rect.size = Vector2(w,w)
	
	draw_rect(rect,Color.WHITE)

func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body is APlayer:
		if body.is_dashing():
			_player_died = false
			_player = body
		else:
			_player_died = true
		

func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body is APlayer:
		_player = null
		if not _player_died:

			use_actions.call_deferred()
			play_used_sound()
			if timed:
				_start_timer()
	pass # Replace with function body.

func play_used_sound():
	$AudioStreamPlayer2D.stream = used_sound
	if not timed or $Timer.is_stopped():
		$AudioStreamPlayer2D.play()

func _start_timer():
	if $Timer.time_left > 0:
		return

	$Timer.start(timed_duration)
	$ProgressBar2D.start(timed_duration)
	$Line2D.default_color = timed_color_override

func _process(_delta):
	if _player and not _player.is_dashing():
		_handle_player_death()

func _handle_player_death():
	_player_died = true
	var _last_safe_pos = _player.get_last_safe_position()
	_player.die()


func _on_timer_timeout() -> void:
	_actions_disabled = false
	$Line2D.default_color = override_color

	$AudioStreamPlayer2D.stream = available_sound
	$AudioStreamPlayer2D.play()
	use_actions()
