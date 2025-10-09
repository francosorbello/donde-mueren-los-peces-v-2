extends PathFollow2D
class_name AirCurrentFollower

@export var initial_speed : float = 20
@export var max_speed : float = 50
@export var time_to_reach_max_speed : float = 1

signal finished_path

var moving : bool = false
var current_direction : Vector2

var _prev_pos : Vector2
var _accoumulated_sample_time : float

func reset():
	progress_ratio = 0
	h_offset = 0
	v_offset = 0
	_accoumulated_sample_time = 0

func start():
	reset()
	moving = true

func start_from(pos : Vector2):
	reset()
	
	# fairly cursed method to get closest point in curve to player,
	# so we can move the pathfollow object tot said position
	if get_parent() is PolygonCurve2D:
		var curve = get_parent().curve as Curve2D
		var offset = curve.get_closest_offset(get_parent().to_local(pos))
		var curve_point = curve.sample_baked(offset)
		var distance = global_position.distance_to(curve_point)
		
		progress += distance

	# progress += distance
	moving = true

func offset_by(offset : Vector2):
	var dir = Vector2(-current_direction.y,current_direction.x)
	h_offset += dir.x * offset.x
	v_offset += dir.y * offset.y

func stop():
	moving = false
	reset()

func _physics_process(delta):
	if not moving:
		return
	if progress_ratio > 0.99:
		finished_path.emit()
		stop()
		return
	
	progress += delta * get_speed()
	current_direction = (_prev_pos-global_position).normalized()
	_prev_pos = global_position
	_accoumulated_sample_time += delta

	
func get_speed():
	return lerp(
		initial_speed,
		max_speed,
		max(_accoumulated_sample_time/time_to_reach_max_speed,1)
	)
