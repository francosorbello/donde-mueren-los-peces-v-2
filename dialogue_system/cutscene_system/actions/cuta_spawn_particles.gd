extends CutsceneAction

@export var particles : PackedScene
@export var spawn_position : Marker2D

func do_action():
    var particles_instance : Node2D = particles.instantiate()    
    particles_instance.global_position = spawn_position.global_position
    
    add_child(particles_instance)
    particles_instance.emitting = true