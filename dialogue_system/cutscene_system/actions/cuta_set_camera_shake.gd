extends CutsceneAction

enum SetTo{
    ENABLED,
    DISABLED
}

@export var set_to : SetTo
@export var keep_after_dialogue : bool = false

func do_action():
    var camera = get_tree().get_first_node_in_group("DialogueCamera")
    assert(camera)

    match set_to:
        SetTo.ENABLED:
            camera.start_shake()
        SetTo.DISABLED:
            camera.stop_shake()
    camera.keep_after_dialogue = keep_after_dialogue
