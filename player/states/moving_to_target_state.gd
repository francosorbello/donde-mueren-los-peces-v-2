extends PlayerState

@export var distance_stop_treshold : float = 1
var target : Node2D
var next_state : String

func enter():
    player.play_anim("move")

func exit():
    target = null
    next_state = ""

func receive_message(message : Dictionary):
    if message.has("target"):
        target = message["target"]
    if message.has("next_state"):
        next_state = message["next_state"]

    print("moving player to target %s, then exiting to state %s"%[target,next_state])

func physics_update(delta: float):
    if not target:
        return
    var direction = (target.global_position - player.global_position).normalized()
    # player.velocity = lerp(player.velocity,direction * player.speed, delta * player.accel)
    player.velocity = FreyaMath.lerp_exp_decay(player.velocity,direction * player.speed, 10, delta * player.accel)
    player.move_and_slide()
    
    if target.global_position.distance_to(player.global_position) < distance_stop_treshold:
        state_machine.transition_to(next_state)
