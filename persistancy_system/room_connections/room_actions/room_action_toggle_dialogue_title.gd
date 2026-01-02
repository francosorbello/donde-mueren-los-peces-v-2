extends RoomAction
class_name RoomActionToggleDialogueTitle

@export var target : Node2D
@export var new_title : String

var _original_title : String

func _ready():
    assert(target and "title" in target)
    assert(not new_title.is_empty())

    _original_title = target.title

func use():
    if target.title == new_title:
        target.title = _original_title
    else: 
        target.title = new_title
