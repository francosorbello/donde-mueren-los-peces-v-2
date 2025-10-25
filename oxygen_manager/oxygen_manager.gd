extends Node

enum DepletionType {
    NORMAL, # Depletion time is not explicit. User defines a depletion rate, and how much it deplets each time. Depletion is descrete (eg: -x oxygen every y seconds)
    FIXED_TIME, # Depletion time is an explicit value. Depletion amound is adjusted to reach 0 in the defined time.  Depletion is descrete (eg: -x oxygen every y seconds)
    TIMER, # Depletion is continuos. Basically just a normal timer
}

@export var depletion_type : DepletionType

@export_category("Normal")
@export var initial_oxygen : float = 100
@export var depletion_rate_secs : float = 1 ## depletion rate of oxygen, in seconds
@export var depletion_amount : float = 1

@export_category("Fixed time")
## if true, depletion_rate_secs and amount will be overriden
## so oxygen reaches 0 in fixed_depletion_time
@export var deplete_over_fixed_time : bool = false
@export var fixed_depletion_time_secs : float = 180
@export var fixed_depletion_secs : float = 5

@export_category("Timer")
@export var timer_duration : float = 180

var current_oxygen : float
signal oxygen_depleted(depletion_amount : float)
signal oxygen_run_out()
signal oxygen_restored(restore_amount : float)
signal oxygen_depletion_stopped()

func _ready():
    print("Oxygen manager is setup as %s"%DepletionType.find_key(depletion_type))
    match depletion_type:
        DepletionType.NORMAL:
            pass
        DepletionType.FIXED_TIME:
            depletion_rate_secs = fixed_depletion_secs
            depletion_amount = depletion_rate_secs * (initial_oxygen / fixed_depletion_time_secs)
            print("Oxygen manager will deplete %f every %f seconds"%[depletion_amount,depletion_rate_secs])
        DepletionType.TIMER:
            depletion_rate_secs = 1
            depletion_amount = depletion_rate_secs * (initial_oxygen / timer_duration)
            print("Oxygen manager will deplete %f every %f seconds"%[depletion_amount,depletion_rate_secs])
            pass
    reset()

func reset():
    current_oxygen = initial_oxygen
    stop_depletion()

func start_depletion():
    $DepletionTimer.start(depletion_rate_secs)

func stop_depletion():
    $DepletionTimer.stop()
    oxygen_depletion_stopped.emit()

func _on_depletion_timer_timeout() -> void:
    deplete_by(depletion_amount)
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