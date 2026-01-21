extends Node2D

@export var game_outro_scene : PackedScene
@export var wc_kai : Node2D
@export var wc_ab : Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is APlayer:
		$Area2D.set_deferred("monitoring",false)
		$Area2D.set_deferred("monitorable",false)
		
		# body.move_to.call_deferred($Marker2D)
		# _reduce_step_sounds.call_deferred(body)

		body.disable_controls.call_deferred()
		exit_to_menu.call_deferred()

func exit_to_menu():
	GlobalData.main_screen_manager.transition_to("GameOutro")
	# var game_outro = game_outro_scene.instantiate()
	# game_outro.modulate.a = 0
	# get_tree().get_first_node_in_group("music").get_parent().add_child(game_outro)
	
	# var tween := create_tween()
	# tween.tween_property(game_outro,"modulate:a",1,1)

func _reduce_step_sounds(player : APlayer):
	if player:
		var step_sounds = player.get_node_or_null("StepSounds")
		if step_sounds:
			var tween := create_tween()
			tween.tween_property(step_sounds,"volume_linear",0,1)
	
	var ab_sounds = wc_ab.get_node_or_null("StepSounds")
	var tween_ab := create_tween()
	tween_ab.tween_property(ab_sounds,"volume_linear",0,1)

	var kai_sounds = wc_kai.get_node_or_null("StepSounds")
	var tween_kai := create_tween()
	tween_kai.tween_property(kai_sounds,"volume_linear",0,1)
