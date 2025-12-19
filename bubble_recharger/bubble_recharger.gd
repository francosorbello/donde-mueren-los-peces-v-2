extends Node2D

func _ready():
	$AnimatedSprite2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is APlayer:
		body.do_jump()

func _draw() -> void:
	draw_circle(Vector2.ZERO,7,Color(1,1,1,0.45))

func do_toggle():
	visible = not visible
	