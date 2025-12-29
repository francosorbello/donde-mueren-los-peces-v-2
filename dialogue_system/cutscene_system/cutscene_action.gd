@abstract
extends Node
class_name CutsceneAction

enum Execute {
    ON_START,
    ON_END
}

@export var execute : Execute = Execute.ON_START
@abstract func do_action()