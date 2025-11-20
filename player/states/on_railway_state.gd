extends PlayerState

@export_category("Dependencies")
@export var fall_detection_component : Node2D

func enter():
	fall_detection_component.can_fall = false
	player.play_anim("idle")
	player.velocity = Vector2.ZERO

func exit():
	fall_detection_component.can_fall = true
	var vel = Vector2.ZERO
	player.add_extra_velocity(vel,.3)
