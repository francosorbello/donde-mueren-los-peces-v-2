extends Control

var _last_character : String

func setup_for_characters(characters : Array[String]):
    if characters.has("Kai"):
        $KaiPortrait.show_portrait()
    
    if characters.has("Ab"):
        $AbPortrait.show_portrait()
    
func toggle_portrait(for_character : String):
    if for_character.is_empty():
        $KaiPortrait.blur_portrait()
        $AbPortrait.blur_portrait()
        _last_character = ""
        return
    
    if for_character != _last_character:
        match for_character:
            "Kai":
                $KaiPortrait.focus_portrait()
                $AbPortrait.blur_portrait()
            "Ab":					
                $KaiPortrait.blur_portrait()
                $AbPortrait.focus_portrait()
            # _:
            #     push_error("No character named %s"%for_character)
    
    _last_character = for_character

func hide_portrait_for(character_name):
    match character_name:
        "Kai":
            $KaiPortrait.hide_portrait()
        "Ab":
            $AbPortrait.hide_portrait()