extends Node

enum ChangeType {
    TRANSITION_TO,
    STOP,
    TRANSITION_TO_INMEDIATE,
}
@export var change_type : ChangeType
@export var music_name : String

func _ready() -> void:
    var music = get_tree().get_first_node_in_group("music")
    if change_type == ChangeType.STOP:
        music.stop_music()
    elif change_type == ChangeType.TRANSITION_TO:
        music.transition_to(music_name)
    elif change_type == ChangeType.TRANSITION_TO_INMEDIATE:
        music.transition_to_inmediate(music_name)