@tool
extends Path2D
class_name DeathZone

@export_tool_button("Create", "Callable") var create_death_zone_action = create_death_zone
@export var width : float = 10
@export_flags_2d_physics var collision_layer
@export var polygon_material : ShaderMaterial

var polygon_shape : Polygon2D
var collision_polygon : CollisionPolygon2D
var collision_area : Area2D

func _ready() -> void:
	# create_death_zone()
	pass

func spawn_required_children():
	for child in get_children():
		child.queue_free()

	collision_area = Area2D.new()
	collision_area.name = "Area2D"
	collision_area.collision_layer = collision_layer
	collision_area.collision_mask = collision_layer
	
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.name = "CollisionPolygon2D"
	collision_area.add_child(collision_polygon)

	add_child(collision_area)
	collision_area.owner = get_tree().edited_scene_root
	collision_polygon.owner = collision_area.owner
	
	polygon_shape = Polygon2D.new()
	polygon_shape.name = "Polygon2D"
	if polygon_material:
		polygon_shape.material = polygon_material#.duplicate()
	add_child(polygon_shape)
	polygon_shape.owner = get_tree().edited_scene_root
	

func create_death_zone():
	spawn_required_children()
		
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
	
	polygon_shape.polygon = polygon
	collision_polygon.polygon = polygon
	# $Line2D.points = polygon

func clear_death_zone():
	polygon_shape.polygon = []
	collision_polygon.polygon = []
	# $Line2D.points = []
