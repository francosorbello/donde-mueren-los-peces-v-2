@tool
extends Path2D

@export_tool_button("Create", "Callable") var create_death_zone_action = create_death_zone
@export var width : float = 10

func _ready() -> void:
	# create_death_zone()
	pass

func create_death_zone():
	if curve.get_baked_points().is_empty():
		clear_death_zone()
		return

	var start_point = curve.get_baked_points()[0]
	var end_point = curve.get_baked_points()[curve.get_baked_points().size()-1]

	var p1 = Vector2(start_point.x,start_point.y + width/2)
	var p2 = Vector2(end_point.x  , start_point.y + width/2)
	var p3 = Vector2(end_point.x  , end_point.y - width/2)
	var p4 = Vector2(start_point.x, start_point.y - width/2)
	
	var polygon : PackedVector2Array = []
	
	polygon.append(p1)
	polygon.append(p2)
	polygon.append(p3)
	polygon.append(p4)
	
	$Area2D/Polygon2D.polygon = polygon
	$Area2D/CollisionPolygon2D.polygon = polygon
	# $Line2D.points = polygon

func clear_death_zone():
	$Area2D/Polygon2D.polygon = []
	$Area2D/CollisionPolygon2D.polygon = []
	# $Line2D.points = []
