@tool
extends Node2D

enum LaserDirection {
	HORIZONTAL,
	VERTICAL
}
@export var direction : LaserDirection
@export var end_point : float:
	set(value):
		end_point = value
		if Engine.is_editor_hint():
			queue_redraw()

@export var width : float = 10:
	set(value):
		width = value
		if Engine.is_editor_hint():
			queue_redraw()

@export_category("Extremes")
@export var visible_extremes : bool = false
@export var extreme_radius : float = 10
@export var extreme_color : Color = Color.RED

@export_category("Time related")
@export var inactive_duration : float = 3
@export var charging_duration : float = 2
@export var active_duration : float = 3

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	setup()

func setup():
	if end_point == 0:
		return

	var p0 = Vector2.ZERO
	var p1 = _get_end_point()

	var points = [p0,p1]

	$LaserLine.end_point = _get_end_point()
	$LaserLine.width = width / 2
	$LaserLine.create()
	$LaserLine.hide()

	$IndicatorLine.points = points
	$IndicatorLine.width = width
	$IndicatorLine.hide()


	var rect_shape = RectangleShape2D.new()
	var size : Vector2
	if direction == LaserDirection.HORIZONTAL:
		size = Vector2(abs(end_point),width)
	else:
		size = Vector2(width, abs(end_point))
	
	rect_shape.size = size

	$Hurtbox/CollisionShape2D.shape = rect_shape
	$Hurtbox/CollisionShape2D.position = _get_end_point() / 2
	$Hurtbox.disable()

	$PlatformArea/CollisionShape2D.shape = rect_shape.duplicate()
	$PlatformArea/CollisionShape2D.position = _get_end_point() / 2

	$Particles/EndParticles.position = _get_end_point()
	$Particles/BoxParticles.position = _get_end_point() / 2
	$Particles/BoxParticles.emission_rect_extents = size / 2

func deactivate_laser():
	$LaserLine.hide()
	$LaserLine.stop_anim()

	toggle_particles(false)

	$IndicatorLine.hide()
	$Hurtbox.disable()

func activate_laser():
	$LaserLine.show()
	$LaserLine.start_anim()

	show_beam_anim()
	toggle_particles(true)

	$Hurtbox.enable()

func toggle_particles(to_value : bool):
	# $Particles/StartParticles.emitting = to_value
	# $Particles/EndParticles.emitting = to_value
	$Particles/BoxParticles.emitting = to_value

func start_charging_anim(duration : float):
	var indicator_line : Line2D = $IndicatorLine
	indicator_line.width = 0
	indicator_line.show()

	var tween := create_tween()
	tween.tween_property(indicator_line,"width",width*2,duration)
	tween.finished.connect(func():
		indicator_line.visible = false
	)

func show_beam_anim():
	var main_line : Line2D = $LaserLine
	main_line.width = 0
	main_line.show()

	var tween := create_tween()
	tween.tween_property(main_line,"width",width/2,0.1)

func hide_beam_anim():
	var main_line : Line2D = $LaserLine

	var tween := create_tween()
	tween.tween_property(main_line,"width",0,0.1)

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_line(Vector2.ZERO,_get_end_point(),Color(1,.4,1,0.4), width)
		return

	if visible_extremes:
		draw_circle(Vector2.ZERO,extreme_radius,extreme_color)
		draw_circle(_get_end_point(),extreme_radius,extreme_color)

func _get_end_point() -> Vector2:
	if direction == LaserDirection.HORIZONTAL:
		return Vector2(end_point,0)
	else:
		return Vector2(0,end_point)
