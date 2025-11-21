extends Path2D

@export var speed : float = 200

var direction : Vector2

func _ready():
	setup()

func setup():
	if curve == null or curve.point_count == 0:
		return

	var curve_points = []
	for i in range(0,curve.point_count):
		curve_points.append(curve.get_point_position(i))
	
	$Line2D.points = curve_points

	$StartPoint.position = curve_points.front()
	$EndPoint.position = curve_points.back()
	direction = (curve_points.back() - curve_points[curve_points.size()-2]).normalized()
	$RailwaySound.position = curve_points.back()/2
	
	$RailwayFollower.started.connect(func():
		$RailwaySound.play()
	)

	$RailwayFollower.stopped.connect(func():
		$RailwaySound.stop()
	)

func _on_start_interactable_on_interact() -> void:
	$RailwayFollower.start(speed, true)
	$RailwaySound.play()


func _on_end_interactable_on_interact() -> void:
	$RailwayFollower.start(speed,false)
