extends Area2D
class_name Hurtbox


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
	_collision_shape.set_deferred("disabled",true)
	# _collision_shape.disabled = true

func _on_area_shape_entered(_area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area is not Hitbox:
		return
	
	var other_shape_owner = area.shape_find_owner(area_shape_index)
	var other_shape : Shape2D = area.shape_owner_get_shape(other_shape_owner,area_shape_index)

	var local_shape_owner = shape_find_owner(local_shape_index)
	var local_shape : Shape2D = shape_owner_get_shape(local_shape_owner,local_shape_index)

	var collision_points = local_shape.collide_and_get_contacts(owner.global_transform,other_shape,area.owner.global_transform)

	if collision_points.is_empty():
		print("No collision points for some reason")
		return

func _on_area_entered(area: Area2D) -> void:
	if area is not Hitbox:
		return

	var data = HitData.create((global_position- area.global_position).normalized())
	area.receive_hit(data) 
