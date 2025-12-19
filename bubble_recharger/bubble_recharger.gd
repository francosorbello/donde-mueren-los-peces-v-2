extends Node2D

var disabled : bool = false

func _ready():
	$AnimatedSprite2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is APlayer:
		body.do_jump()

func _draw() -> void:
	draw_circle(Vector2.ZERO,7,Color(1,1,1,0.45))

func do_toggle():
	disabled = not disabled
	$Area2D/CollisionShape2D.disabled = disabled
	if not disabled:
		$UnlockSound.play()
	do_toggle_anim()

func do_toggle_anim():
	var tween := create_tween()
	var anim_to : Vector2

	if disabled:
		anim_to = Vector2.ZERO
	else:
		anim_to = Vector2.ONE

	tween.tween_property(self,"scale",anim_to,0.5)
