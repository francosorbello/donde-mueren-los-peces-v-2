extends Node2D

@export var bubble_data : BubbleCBData
@export_flags_2d_physics var collision_mask

var enabled : bool = false

var points : Array[Vector2]
var _test_point : Vector2
var _test_font = ThemeDB.fallback_font

var _path_calculator

func show_path(path_calculator : Node):
	if enabled: return

	_path_calculator = path_calculator 
	enabled = true

func hide_path():
	print("hide path")
	enabled = false
	points.clear()
	$Line2D.points = []
	queue_redraw()

func _physics_process(_delta):
	if not enabled or not visible: return

	await _path_calculator.calc_finished

	points = _path_calculator.get_points_for(global_position)
	$Line2D.points = points
	queue_redraw()

func _draw():
	if points.size() > 1:
		draw_circle(points[0],2,Color.WHITE)
		draw_circle(points.back(),2,Color.WHITE)

# func _draw() -> void:
# 	for p in points:
# 		draw_circle(p,2,Color.RED)
# 		draw_string(_test_font,p+Vector2(5,0),"%s"%p,0,-1,8)
# 	if _test_point:
# 		draw_circle(_test_point,2,Color.YELLOW)
