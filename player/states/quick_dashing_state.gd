extends PlayerState

@export var move_speed : float = 200
@export var distance_to_travel : float = 40

@export_category("Dependencies")
@export var death_zone_hurtbox : Area2D

var _distance_traveled : float

var _initial_pos : Vector2

func enter():
    _initial_pos = player.global_position
    $DashSound.play()

func exit():
    death_zone_hurtbox.toggle_active(true)

func physics_update(delta: float):
    _distance_traveled = (_initial_pos - player.global_position).length()
    if _distance_traveled > distance_to_travel:
        state_machine.transition_to("MovingState")
        return

    # player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,player.last_direction * move_speed, 10, delta*player.accel)
    player.move_and_slide()