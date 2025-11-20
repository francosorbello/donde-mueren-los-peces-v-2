extends State

func enter():
    var duration = state_owner.active_duration
    state_owner.activate_laser()

    $ActiveTimer.start(duration)
    $ElectricitySound.play()

func exit():
    $ElectricitySound.stop()

func _on_active_timer_timeout() -> void:
    state_machine.transition_to("DisabledState")
    pass # Replace with function body.
