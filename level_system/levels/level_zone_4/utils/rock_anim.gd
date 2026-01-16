extends Node2D


func play_crush_sound():
	CommonSfxPlayer.play_sound("rock")

func start_anim():
	await get_tree().create_timer(randf_range(0,1)).timeout
	$AnimationPlayer.play("falling_rock")
