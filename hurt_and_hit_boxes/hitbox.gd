extends Area2D
class_name Hitbox

signal on_hit(hit_data : HitData)

var _collision_shape : CollisionShape2D:
    get():
        if _collision_shape == null:
            for child in get_children():
                if child is CollisionShape2D:
                    _collision_shape = child
                    break
        return _collision_shape

func enable():
    _collision_shape.disabled = false

func disable():
    _collision_shape.disabled = true

func receive_hit(hit_data : HitData):
    on_hit.emit(hit_data)
    pass