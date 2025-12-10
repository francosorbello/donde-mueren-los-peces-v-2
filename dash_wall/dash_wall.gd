@tool
extends PolygonCurve2D
class_name DashWall

@export_flags_2d_physics var collision_layer : int
@export var polygon_material : ShaderMaterial
@export var polygon_texture : Texture2D

@export_category("Ouline")
@export var outline_color : Color = Color.WHITE
@export var outline_width : float = 1

var static_collision : StaticBody2D
var static_collision_polygon : CollisionPolygon2D
var line_outline : Line2D

func spawn_required_children():
    super()
    # return

    static_collision = StaticBody2D.new()
    add_child(static_collision)
    static_collision.owner = get_tree().edited_scene_root
    static_collision.collision_layer = collision_layer
    static_collision.collision_mask = collision_layer

    static_collision_polygon = CollisionPolygon2D.new()
    static_collision.add_child(static_collision_polygon)
    static_collision_polygon.owner = get_tree().edited_scene_root

    line_outline = Line2D.new()
    add_child(line_outline)
    line_outline.owner = get_tree().edited_scene_root
    line_outline.width = outline_width
    line_outline.closed = true
    line_outline.joint_mode = Line2D.LINE_JOINT_ROUND
    line_outline.default_color = outline_color

    if polygon_shape: 
        if polygon_texture:
            polygon_shape.texture = polygon_texture

        if polygon_material:
            polygon_shape.material = polygon_material

func create():
    super()
    _set_static_col_polygon()
    _set_outline()

func _create_from_path():
    super()
    _set_static_col_polygon()
    _set_outline()

func _set_static_col_polygon():
    if not polygon_points.is_empty() and static_collision_polygon:
        static_collision_polygon.polygon = polygon_points

func _set_outline():
    if not polygon_points.is_empty():
        line_outline.points = polygon_points

func set_polygon_shape_uvs():
    var tex_size = polygon_shape.texture.get_size()
    var p0 = Vector2(0,tex_size.y)
    var p1 = tex_size
    var p2 = Vector2(tex_size.y,0)
    var p3 = Vector2.ZERO

    polygon_shape.uv = PackedVector2Array([
        p0,p1,p2,p3
    ])
    prints(polygon_shape.name, polygon_shape.uv)