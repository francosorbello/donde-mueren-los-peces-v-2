extends Node

@export var floor_detector : FloorDetector
@export var state_machine : StateMachine

var last_safe_position : Vector2

var player : APlayer

func _ready() -> void:
	player = get_parent() as APlayer
	if not player:
		print("Parent is not a player")
		return
	
	last_safe_position = player.global_position
	state_machine.switched_states.connect(_on_switched_states)
	floor_detector.floor_status_changed.connect(_on_floor_status_change)
	$RefreshPositionTimer.timeout.connect(_on_refresh_position_timer_timeout)
	$RefreshPositionTimer.start()

func _on_switched_states(_from : String, to : String):
	if to == "IdleState" or to == "MovingState":
		_start_timer()
	else:
		$RefreshPositionTimer.stop()

func _on_refresh_position_timer_timeout():
	if floor_detector.current_status != FloorDetector.DetectionStatus.FALLING:
		last_safe_position = player.global_position
		# print("Last safe position: ",last_safe_position)

func _on_floor_status_change(status : FloorDetector.DetectionStatus):
	if status == FloorDetector.DetectionStatus.FALLING:
		$RefreshPositionTimer.stop()
	else:
		_start_timer(true)

func _start_timer(force_restart : bool = false):
	if $RefreshPositionTimer.is_stopped() or force_restart:
		$RefreshPositionTimer.start()
