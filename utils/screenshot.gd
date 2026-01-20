extends Node

const characters = 'abcdefghijklmnopqrstuvwxyz'


func _ready():
    if OS.is_debug_build():
        process_mode = Node.PROCESS_MODE_ALWAYS
        Console.add_command("take_screenshot",take_screenshot)

func take_screenshot():
    if Console.is_visible():
        Console.toggle_console()
        await get_tree().create_timer(1).timeout
    var img = get_viewport().get_texture().get_image()
    img.save_png("res://tests/screenshots/%s.png"%generate_word(characters,5))
    print("Screenshot saved to %s"%"res://tests/screenshots/")

func generate_word(chars, length):
    var word: String = ""
    var n_char = len(chars)
    for i in range(length):
        word += chars[randi()% n_char]
    return word
