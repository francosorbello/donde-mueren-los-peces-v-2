extends StaticBody2D

func _on_hitbox_on_hit(_hit_data: HitData) -> void:
    queue_free()
