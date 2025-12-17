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

func _ready():
	if Engine.is_editor_hint():
		return

	setup()

func setup():
	var points = [
		_get_start_point(),
		_get_end_point()
	]

	$Line2D.points = points
	$Line2D.width = width
	# $AnimationPlayer.play("pulse")

	var rect_shape = RectangleShape2D.new()
	var size : Vector2
	if direction == LaserDirection.HORIZONTAL:
		size = Vector2(abs(end_point),width)
	else:
		size = Vector2(width, abs(end_point))
	
	rect_shape.size = size
	$Hurtbox/CollisionShape2D.shape = rect_shape
	$Hurtbox/CollisionShape2D.position = _get_end_point() / 2 + (_get_start_point() / 2)

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
