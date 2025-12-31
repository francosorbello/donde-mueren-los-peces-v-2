extends CutsceneAction

@export var target : Node2D

var player : APlayer

func do_action():
    if execute == Execute.ON_START:
        await get_tree().process_frame
    player = get_tree().get_first_node_in_group("player")
    
    assert(player != null, "(%s) No player to move"%name)
    assert(target != null, "(%s) No target to move the player to"%name)
    
    player.move_to(target)
