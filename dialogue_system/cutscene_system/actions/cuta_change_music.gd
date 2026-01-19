extends CutsceneAction

enum ChangeType {
    TRANSITION_TO,
    STOP,
    START,
    TRANSITION_TO_INMEDIATE
}

@export var music_name : String
@export var change_type : ChangeType = ChangeType.TRANSITION_TO 

func do_action():
    var music = get_tree().get_first_node_in_group("music")
    assert(music != null)

    match change_type:
        ChangeType.TRANSITION_TO:
            music.transition_to(music_name)
        ChangeType.START:
            music.start_music(music_name)
        ChangeType.STOP:
            music.stop_music()    
        ChangeType.TRANSITION_TO_INMEDIATE:
            music.transition_to_inmediate(music_name)
