@abstract
extends Node
class_name CutsceneAction

enum Execute {
    ON_START,
    ON_EVENT,
    ON_END
}

@export var execute : Execute = Execute.ON_START
@export var event_name : String
@export var wait_time : float = 0

@abstract func do_action()