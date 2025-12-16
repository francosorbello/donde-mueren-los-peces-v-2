@tool
extends PolygonCurve2D
class_name BetterDeathZone

@export_flags_2d_physics var collision_layer : int
@export var polygon_material : ShaderMaterial
@export var polygon_texture : Texture2D
@export var particles_scene : PackedScene

var particles : CPUParticles2D

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

    particles = particles_scene.instantiate()
    add_child(particles)
    particles.name += str(randi_range(0,1000))
    particles.owner = get_tree().edited_scene_root

func create():
    super()
    if not polygon_shape:
        return
    var poly_rect = get_polygon_rect(polygon_shape.polygon)
    prints(poly_rect,poly_rect.get_center())
    particles.position = poly_rect.get_center()
    particles.emission_rect_extents = poly_rect.size/2 + Vector2(10,10)


func set_polygon_shape_uvs():
    var tex_size = polygon_shape.texture.get_size()
    var p0 = Vector2(0,tex_size.y)
    var p1 = tex_size
    var p2 = Vector2(tex_size.y,0)
    var p3 = Vector2.ZERO

    polygon_shape.uv = [p0,p1,p2,p3]

func get_polygon_rect(points: PackedVector2Array) -> Rect2:
    var rect = Rect2()
    if points.is_empty():
        return rect

    var min_point = points[0]
    var max_point = points[1]
    for point in points:
        if point.x < min_point.x or point.y < min_point.y:
            min_point = point
        if point.x > max_point.x or point.y > max_point.y:
            max_point = point
        # rect = rect.expaAnd(point)
    
    rect.position = min_point
    rect.end = max_point
    return rect