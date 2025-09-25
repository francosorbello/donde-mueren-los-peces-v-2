extends RigidBody2D

@export var start_force : float = 200

signal popped

func start(dir : Vector2):
	apply_central_impulse(dir * start_force)

func _on_dead_timer_timeout() -> void:
	popped.emit(self)
	pass # Replace with function body.
