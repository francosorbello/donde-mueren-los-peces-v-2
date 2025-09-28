extends Node2D

func _ready() -> void:
	disable()
	pass

func disable():
	$Hurtbox.disable()
	hide()

func enable():
	$Hurtbox.enable()
	show()

func do_attack(direction : Vector2):
	rotation = direction.angle()
	enable()
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	disable()
