extends RigidBody2D
class_name ABubbleRB

@export var start_force : float = 200
@export var hit_force : float = 400

signal popped

var can_be_targeted : bool = true

func start(dir : Vector2):
	apply_central_impulse(dir * start_force)

func _on_dead_timer_timeout() -> void:
	pop()

func pop():
	$StateMachine.transition_to("DeadState")

func _on_hitbox_on_hit(hit_data : HitData) -> void:
	apply_central_impulse(-hit_data.collision_normal * hit_force)
	pass # Replace with function body.

func get_anim_player():
	return $AnimatedSprite2D

func set_as_dash_target():
	if not can_be_targeted:
		return
	can_be_targeted = false
	$StateMachine.transition_to("DashingState")

func clear_as_dash_target():
	pop()