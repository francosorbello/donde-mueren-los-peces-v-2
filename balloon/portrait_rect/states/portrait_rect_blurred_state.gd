extends State

@export var blurred_position : Vector2
var first_enter : bool = true

func enter():
    state_owner.modulate = Color(1,1,1,0.6)
    if first_enter:
        state_owner.move_to_anim(blurred_position)
        first_enter = false
    else:
        state_owner.move_to_anim(blurred_position,0.1)
        