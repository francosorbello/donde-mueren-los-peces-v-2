extends Node

@export var initial_oxygen : float = 100
@export var depletion_rate_secs : float = 1 ## depletion rate of oxygen, in seconds
@export var depletion_amount : float = 1 

var current_oxygen : float
signal oxygen_depleted(depletion_amount : float)
signal oxygen_run_out()
signal oxygen_restored(restore_amount : float)

func _ready():
    reset()

func reset():
    current_oxygen = initial_oxygen
    stop_depletion()

func start_depletion():
    $DepletionTimer.start(depletion_rate_secs)

func stop_depletion():
    $DepletionTimer.stop()

func _on_depletion_timer_timeout() -> void:
    deplete_by(depletion_rate_secs)
    pass # Replace with function body.

func deplete_by(amount : float):
    var new_amount = current_oxygen - amount
    if new_amount <= 0:
        current_oxygen = 0
        oxygen_run_out.emit()
        return

    current_oxygen = new_amount 
    oxygen_depleted.emit(amount)

func restore_by(amount : float):
    var new_amount = max(current_oxygen + amount, initial_oxygen)

    current_oxygen = new_amount
    oxygen_restored.emit(amount)

func get_max_oxygen() -> float:
    return initial_oxygen