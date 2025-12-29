extends CutsceneAction

@export var focus_on_player : bool = false
@export var target : Node2D

func do_action():
    if focus_on_player:
        target = get_tree().get_first_node_in_group("player")

    assert(target != null, "(%s) No target to focus on"%name)

    var camera = get_tree().get_first_node_in_group("DialogueCamera")
    camera.set_target(target)