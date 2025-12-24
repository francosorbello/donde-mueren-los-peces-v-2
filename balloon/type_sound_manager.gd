extends AudioStreamPlayer

@export var dialogue_label : DialogueLabel
var _profiles : CharacterContainerResource

var _has_character : bool = true

func _ready() -> void:
    await get_parent().ready
    _profiles = get_parent().character_container
    dialogue_label.spoke.connect(_on_spoke)

func set_character(character_name : String):
    if character_name.is_empty():
        _has_character = false
        return

    var character = _profiles.get_character_named(character_name)
    if character:
        stream = character.speak_sound
        _has_character = true

func _on_spoke(_letter: String, _letter_index: int, _speed: float):
    if playing or not _has_character:
        return

    pitch_scale = randf_range(0.7,1.3)
    play()
