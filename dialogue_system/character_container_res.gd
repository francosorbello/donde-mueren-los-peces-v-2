extends Resource
class_name CharacterContainerResource

@export var characters : Array[CharacterResource]

func get_character_named(name : String) -> CharacterResource:
    for character in characters:
        if character.character_name == name:
            return character
    push_error("No character named %s"%name)
    return null