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

@export_category("Room actions")
@export var override_color : Color = Color.GREEN

var _room_actions : Array[RoomAction]

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
	$Hurtbox/CollisionShape2D.shape = hurtbox_shape
	$Hurtbox/CollisionShape2D.position = _get_end_point() / 2 + (_get_start_point() / 2)

	detection_shape.size = size
	$PlayerDetectionArea/CollisionShape2D.shape = detection_shape
	$PlayerDetectionArea/CollisionShape2D.position = _get_end_point() / 2 + (_get_start_point() / 2)


	$BoxParticles.position = _get_end_point() / 2 + (_get_start_point() / 2)
	$BoxParticles.emission_rect_extents = size / 2
	$BoxParticles.emitting = true


	
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
	draw_circle(_get_start_point(),2,Color.WHITE)
	if Engine.is_editor_hint() and is_node_ready():
		var points = [
			_get_start_point(),
			_get_end_point()
		]
		$Line2D.points = points
		$Line2D.width = width

	draw_circle(_get_end_point(),2,Color.WHITE)


func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body is APlayer and body.is_dashing():
		use_actions.call_deferred()
		
func use_actions():
	for child in _room_actions:
		child.use()
