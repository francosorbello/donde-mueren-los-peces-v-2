extends Control

var _last_character : String

func toggle_portrait(for_character : String):
    if for_character.is_empty():
        $KaiPortrait.hide_portrait()
        $AbPortrait.hide_portrait()
        _last_character = ""
        return
    
    if for_character != _last_character:
        match for_character:
            "Kai":
                $KaiPortrait.show_portrait()
                $AbPortrait.hide_portrait()
            "Ab":					
                $KaiPortrait.hide_portrait()
                $AbPortrait.show_portrait()
            _:
                push_error("No character named %s"%for_character)
    
    _last_character = for_character