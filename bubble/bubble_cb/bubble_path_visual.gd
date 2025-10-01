extends Node2D

@export var bubble_data : BubbleCBData
@export_flags_2d_physics var collision_mask

var enabled : bool = false

var _start_pos : Vector2
var _start_direction : Vector2

var _current_pos :Vector2
var _remaining_distance : float 
var _direction : Vector2

var points : Array[Vector2]
var _test_point : Vector2
var _test_font = ThemeDB.fallback_font

func show_path(start_pos : Vector2, direction : Vector2, _max_bounces : int = 1):
	if enabled: return

	_start_pos = start_pos
	_start_direction = direction

	_current_pos = start_pos
	_direction = direction
	_remaining_distance = bubble_data.travel_distance

	enabled = true

func hide_path():
	print("hide path")
	enabled = false
	points.clear()
	$Line2D.points = []
	queue_redraw()

func _reset():
	_current_pos = global_position
	_remaining_distance = bubble_data.travel_distance
	points.clear()

func _physics_process(_delta):
	if not enabled or not visible: return

	# points.clear()
	_reset()
	points.append(Vector2.ZERO)
	_direction = (get_global_mouse_position() - _start_pos).normalized()
	_test_point = Vector2.ZERO
	# breakpoint
	var space_state = get_world_2d().direct_space_state
	for _i in range(0,3):
		# print("query %d from %s to %s with dir %s and remaining dist %.02f"%[_i,_current_pos, _current_pos + (_direction * _remaining_distance),_direction,_remaining_distance])
		
		var next_pos = _current_pos + _direction * _remaining_distance
		
		var query = PhysicsRayQueryParameters2D.create(_current_pos, next_pos,collision_mask)
		var result = space_state.intersect_ray(query)
		if result:
			_remaining_distance = _remaining_distance - (result.position.distance_to(_current_pos))
			_current_pos = result.position - global_position
			_direction = result.normal
			points.append(_current_pos)
		else:
			_test_point = (_direction * _remaining_distance) - global_position
			if _i > 0:
				points.append(_current_pos + _direction * _remaining_distance)
			else:
				points.append(_direction * _remaining_distance)
			break

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
