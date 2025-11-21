extends Node2D

func _ready():
	$AnimatedSprite2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is APlayer:
		body.do_jump()
