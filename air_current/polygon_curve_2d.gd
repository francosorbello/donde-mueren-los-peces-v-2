@tool
extends Path2D
class_name PolygonCurve2D
## Creates a polygon and a collision area based on a curve
## WARNING: use high bake intervals (between 20 and 100), otherwise errors might show up

@export_tool_button("Create", "Callable") var create_action = create
# @export_tool_button("Debug draw") var debug_draw_action = debug_draw
# @export_tool_button("Debug Clear") var debug_clear_action = debug_clear
@export var width : float = 10
@export_range(20,100) var curve_bake_interval : int = 50:
    set(value):
        curve_bake_interval = value
        if curve:
            curve.bake_interval = curve_bake_interval

var polygon_shape : Polygon2D
var collision_polygon : CollisionPolygon2D
var collision_area : Area2D
var path_follower : PathFollow2D

var polygon_points : PackedVector2Array
var debug_polygon_points : PackedVector2Array

func _ready() -> void:
    ## TODO: i lose the reference to the nodes when i play the game
    ## there should be a better fix for this
    if not Engine.is_editor_hint():
        polygon_shape = get_node("Polygon2D")
        collision_area = get_node("Area2D")
        collision_polygon = collision_area.get_node("CollisionPolygon2D")

func _set(property: StringName, value: Variant) -> bool:
    if property == "curve":
        if value:
            value.bake_interval = curve_bake_interval
        else:
            clear()
    return false

func create_from(value : Curve2D):
    curve = value
    create()

func create():
    if not curve or curve.get_baked_points().is_empty():
        clear()
        print("early return")
        return

    spawn_required_children()

    var points := curve.get_baked_points()
    
    var p1_points : PackedVector2Array
    var p2_points : PackedVector2Array

    for i in range(0,points.size() - 1):
        var point := points[i]
        var next_point := points[i+1]
        var direction = (next_point - point).normalized()
        var rot_angle = direction.angle()

        var new_points_transform = Transform2D(rot_angle,point)
        var p1 = new_points_transform * Vector2(0,width/2)
        var p2 = new_points_transform * Vector2(0,-width/2)

        p1_points.append(p1)
        p2_points.append(p2)
    
    # sample an extra point a little bit before the end of the curve
    var last_point = points[points.size()-1]
    var last_point_offset = curve.sample(curve.point_count-2,0.9)

    var last_point_transform = Transform2D((last_point-last_point_offset).angle(),last_point_offset)
    p1_points.append(last_point_transform * Vector2(0,width/2))
    p2_points.append(last_point_transform * Vector2(0,-width/2))

    p1_points.reverse()
    polygon_points = p2_points + p1_points
    
    polygon_shape.polygon = polygon_points
    collision_polygon.polygon = polygon_points

         
    
func debug_clear():
    debug_polygon_points.clear()
    polygon_points.clear()
    queue_redraw()

func debug_draw():
    # polygon_points.clear()
    queue_redraw()    

func spawn_required_children():
    for child in get_children():
        child.queue_free()

    collision_area = Area2D.new()
    collision_area.name = "Area2D"
    
    collision_polygon = CollisionPolygon2D.new()
    collision_polygon.name = "CollisionPolygon2D"
    collision_area.add_child(collision_polygon)

    add_child(collision_area)
    collision_area.owner = get_tree().edited_scene_root
    collision_polygon.owner = collision_area.owner
    
    polygon_shape = Polygon2D.new()
    polygon_shape.name = "Polygon2D"
    add_child(polygon_shape)
    polygon_shape.owner = get_tree().edited_scene_root


func clear():
    if polygon_shape and collision_polygon:
        polygon_shape.polygon = []
        collision_polygon.polygon = []
