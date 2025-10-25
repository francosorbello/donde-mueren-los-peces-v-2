extends Control

@export var fake_mode_enabled : bool = false

@export_category("Fake Mode")
@export var progression_curve : Curve

@onready var progress_bar : ProgressBar = $ProgressBar

@onready var fake_mode_timer : Timer = $FakeModeTimer
var _accoumulated_sample_time : float = 0


func _ready():
    start()
    OxygenManager.oxygen_depleted.connect(_on_oxygen_changed)
    OxygenManager.oxygen_restored.connect(_on_oxygen_changed)
    if fake_mode_enabled:
        OxygenManager.oxygen_depletion_stopped.connect(_on_oxygen_stopped)
        fake_mode_timer.start(OxygenManager.timer_duration)

func start():
    $ProgressBar.value = OxygenManager.get_max_oxygen()

func _process(delta: float) -> void:
    if fake_mode_enabled:
        _accoumulated_sample_time += delta
        # print(get_progress_value())
        progress_bar.value = get_progress_value()
        
        pass

func get_progress_value():
    var sample_point = clampf(_accoumulated_sample_time/fake_mode_timer.wait_time,0.0,1.0)

    var sampled_value = progression_curve.sample(sample_point)
    if progression_curve.min_value < progression_curve.max_value:
        return (1-sampled_value) * OxygenManager.get_max_oxygen()
    else:
        return sampled_value * OxygenManager.get_max_oxygen()

func _on_oxygen_changed(_value):
    if fake_mode_enabled:
        return

    # print("Oxygen changed by %f"%_value)
    var tween := create_tween()
    
    var tween_duration = 0.1
    if _value >= 1:
        tween_duration = _value - 1
    if OxygenManager.depletion_type == OxygenManager.DepletionType.TIMER:
        tween_duration = 1
    
    tween.tween_property($ProgressBar,"value",OxygenManager.current_oxygen,tween_duration)
    # $ProgressBar.value = OxygenManager.current_oxygen


func _on_oxygen_stopped():
    pass