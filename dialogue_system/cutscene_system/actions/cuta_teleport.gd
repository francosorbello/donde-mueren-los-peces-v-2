extends CutsceneAction

@export var target : Node2D
@export var to_pos : Node2D

func do_action():
    assert(target != null)
    assert(to_pos != null)

    target.global_position = to_pos.global_position