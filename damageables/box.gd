extends StaticBody2D

@export var explosion_particle_scene : PackedScene

func _on_hitbox_on_hit(_hit_data: HitData) -> void:
    var particles = explosion_particle_scene.instantiate() as CPUParticles2D
    get_parent().add_child(particles)
    particles.global_position = global_position
    particles.emitting = true
    particles.set_as_autodelete()
    queue_free()
