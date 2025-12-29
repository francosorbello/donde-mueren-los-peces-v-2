extends CutsceneAction

@export var to_position : Marker2D

var player : APlayer

func do_action():
	player = get_tree().get_first_node_in_group("player")
	
	assert(player != null, "(%s) No player to teleport"%name)
	assert(to_position != null, "(%s) No position to teleport to"%name)
	
	player.global_position = to_position.global_position
