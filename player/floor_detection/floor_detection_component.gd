extends Node2D

@export var coyote_time : float = 0.2

signal player_fell

var current_status : FloorDetector.DetectionStatus
var can_fall : bool = true:
	set(value):
		can_fall = value
		if not can_fall:
			stop_coyote_time()
		else:
			_on_floor_detector_floor_status_changed($FloorDetector.current_status)

func _on_floor_detector_floor_status_changed(new_status: FloorDetector.DetectionStatus) -> void:

	# player is falling, start coyote time
	if can_fall and new_status == FloorDetector.DetectionStatus.FALLING:
		start_coyote_time()
	
	# player was falling but its on safe land again, stop_coyote_time coyote time
	if new_status != current_status and current_status == FloorDetector.DetectionStatus.FALLING:
		stop_coyote_time()

	current_status = new_status

func _on_coyote_time_timer_timeout() -> void:
	player_fell.emit()

func stop_coyote_time():
	$CoyoteTimeTimer.stop()

func start_coyote_time():
	$CoyoteTimeTimer.start(coyote_time)
