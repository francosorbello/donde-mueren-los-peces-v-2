@tool
extends PolygonCurve2D
class_name BetterDeathZone

@export_flags_2d_physics var collision_layer
@export var polygon_material : ShaderMaterial
@export var polygon_texture : Texture2D

func spawn_required_children():
    super()

    if collision_area:
        collision_area.collision_layer = collision_layer

    if polygon_shape: 
        if polygon_texture:
            polygon_shape.texture = polygon_texture
            set_polygon_shape_uvs()

        if polygon_material:
            polygon_shape.material = polygon_material

func set_polygon_shape_uvs():
    var tex_size = polygon_shape.texture.get_size()
    var p0 = Vector2(0,tex_size.y)
    var p1 = tex_size
    var p2 = Vector2(tex_size.y,0)
    var p3 = Vector2.ZERO

    polygon_shape.uv = [p0,p1,p2,p3]