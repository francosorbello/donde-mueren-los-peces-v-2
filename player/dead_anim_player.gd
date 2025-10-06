extends Node

var frame_time : float = 0.1
var repeats : int = 10
var playing : bool = false

func _ready() -> void:
	$Timer.timeout.connect(_on_timeout)

func play_anim(sprite : Sprite2D):
	if playing: 
		return
	playing = true
	for _i in range(0,repeats):
		sprite.visible = !sprite.visible
		$Timer.start(frame_time)
		await $Timer.timeout
	pass
	sprite.visible = true
	playing = false


func _on_timeout():
	pass