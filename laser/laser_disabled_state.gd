extends State

func enter():
	var duration = state_owner.inactive_duration
	$InactiveTimer.start(duration)

	state_owner.deactivate_laser()

func _on_inactive_timer_timeout() -> void:
	state_machine.transition_to("ChargingState")
