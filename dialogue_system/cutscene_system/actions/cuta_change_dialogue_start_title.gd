extends CutsceneAction

@export var new_title : String
@export var character : Node2D

func do_action():
    assert(character != null)
    assert(not new_title.is_empty())
    assert("title" in character)

    # print("Changed title on %s, from %s to %s"%[character,character.title,new_title])
    character.title = new_title