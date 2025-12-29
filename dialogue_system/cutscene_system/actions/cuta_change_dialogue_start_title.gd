extends CutsceneAction

@export var new_title : String
@export var character : Node2D

func do_action():
    assert(character != null)
    assert(not new_title.is_empty())
    assert("title" in character)

    character.title = new_title