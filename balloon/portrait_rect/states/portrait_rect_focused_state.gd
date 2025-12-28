extends State

@export var focused_position : Vector2

func enter():
    state_owner.modulate = Color.WHITE
    state_owner.move_to_anim(focused_position)