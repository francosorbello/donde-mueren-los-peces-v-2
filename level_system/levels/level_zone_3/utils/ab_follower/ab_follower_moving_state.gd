extends State

@export var speed : float = 0.5

func enter():
    state_owner.get_animation_player().play("move")

func physics_update(delta: float):
    if state_owner.target:
        var _target_pos = state_owner.target.global_position
        state_owner.global_position = FreyaMath.lerp_exp_decay(state_owner.global_position,_target_pos,5,delta * speed)
        if _target_pos.distance_to(state_owner.global_position) < state_owner.stop_treshold:
            state_machine.transition_to("IdleState")
            