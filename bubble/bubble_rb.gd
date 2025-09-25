extends RigidBody2D

@export var mu_static = 0.8  # friction coefficients
@export var mu_moving = 0.5  # pushing something moving is easier
# mu depends on what material the object is on, so use area detectors and change
# this values depending on ice or mud

@export var move_strength = 50

var applied_forces: Vector2 = Vector2(0, 0)

func add_force_for_frame(force: Vector2):
	# add_force adds a permanent force, for a temporary one we need to wipe it
	# by undo the force next frame, just keep track of forces applied
	applied_forces += force
	self.apply_central_force(force)

func _ready() -> void:
	# no world gravity pushing the object down (in the +y) direction
	# we are top down so gravity is acting into the screen (in +z) but the
	# "ground" normal force is canceling it out
	self.gravity_scale = 0
