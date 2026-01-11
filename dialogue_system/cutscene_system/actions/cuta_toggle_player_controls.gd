extends CutsceneAction

enum ToggleType {
    DISABLE,
    ENABLE,
}

@export var toggle_type : ToggleType

func do_action():
    var player = get_tree().get_first_node_in_group("player")
    assert(player != null)

    match toggle_type:
        ToggleType.ENABLE:
            player.enable_controls()
        ToggleType.DISABLE:
            player.disable_controls()
        _:
            push_error("Toggle type %s is not implemented"%ToggleType.find_key(toggle_type))

