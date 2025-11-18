extends RefCounted
class_name HitData

var collision_normal : Vector2
var damage_entity : Node
var extra_data : Dictionary = {}

static func _create(col_points : PackedVector2Array) -> HitData:
    var result = HitData.new()
    if col_points.is_empty():
        return null
    
    result.collision_points = col_points
    result.collision_normal = (col_points[1]-col_points[0]).normalized()
    
    return result

static func create(col_normal : Vector2, data : Dictionary = {}) -> HitData:
    var result = HitData.new()

    result.collision_normal = col_normal
    result.extra_data = data
    return result