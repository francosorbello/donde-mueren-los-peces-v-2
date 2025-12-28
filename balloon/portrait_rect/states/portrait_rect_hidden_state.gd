extends State

@export var hidden_position : Vector2

func enter():
    state_owner.position = hidden_position 
