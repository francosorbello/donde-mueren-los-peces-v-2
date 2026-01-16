extends Node2D

func play_anim():
    for child in get_children():
        if child.has_method("start_anim"):
            child.start_anim()