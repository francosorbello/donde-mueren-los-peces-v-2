extends State

func enter():
    var duration = state_owner.charging_duration
    $ChargingTimer.start(duration)
    state_owner.start_charging_anim(duration)
    $ChargingSound.play()

func exit():
    $ChargingSound.stop()

func _on_charging_timer_timeout() -> void:
    state_machine.transition_to("ActiveState")
