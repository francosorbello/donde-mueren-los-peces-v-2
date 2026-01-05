extends CutsceneAction

@export var target : Node2D
@export var character : Node2D

func do_action():
    assert(target != null)
    assert(character != null)
    assert(character.has_method("move_to"))

    character.move_to(target.global_position)