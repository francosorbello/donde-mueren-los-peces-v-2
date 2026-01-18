extends AudioStreamPlayer

@export var state_machine : StateMachine

var player : APlayer

func _ready():
    player = get_parent()