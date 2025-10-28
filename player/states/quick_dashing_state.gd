extends PlayerState

@export var move_speed : float = 200
@export var distance_to_travel : float = 40

@export_category("Jumping")
@export var allow_jump : bool = true
@export var allow_jump_treshold = 10

@export_category("Dependencies")
@export var floor_detection_component : Node2D

var _distance_traveled : float

var _initial_pos : Vector2

var _transitioning_to_jump : bool = false

func enter():
    _initial_pos = player.global_position
    _transitioning_to_jump = false
    $DashSound.play()

func exit():
    floor_detection_component.can_fall = not _transitioning_to_jump

func state_unhandled_input(event : InputEvent):
    if event.is_action_pressed("jump"):
        prints("jump pressed",_distance_traveled,_distance_traveled > (distance_to_travel-allow_jump_treshold))
        if allow_jump and _distance_traveled > (distance_to_travel-allow_jump_treshold):
            state_machine.transition_to("JumpingState")
            print("transition to jump state")
            _transitioning_to_jump = true



func physics_update(delta: float):
    if _transitioning_to_jump:
        return
    _distance_traveled = (_initial_pos - player.global_position).length()
    
    if _distance_traveled > distance_to_travel:
        state_machine.transition_to("MovingState")
        print("transition to moving state")
        return

    # player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,player.last_direction * move_speed, 10, delta*player.accel)
    player.move_and_slide()
    
    if player.get_slide_collision_count() > 0:
        state_machine.transition_to("MovingState")