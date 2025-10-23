extends Control

func _ready():
    start()
    OxygenManager.oxygen_depleted.connect(_on_oxygen_changed)
    OxygenManager.oxygen_restored.connect(_on_oxygen_changed)

func _on_oxygen_changed(_value):
    # print("Oxygen changed by %f"%_value)
    var tween := create_tween()
    var tween_duration = 0.1
    if _value >= 1:
        tween_duration = _value - 1
    tween.tween_property($ProgressBar,"value",OxygenManager.current_oxygen,tween_duration)
    # $ProgressBar.value = OxygenManager.current_oxygen

func start():
    $ProgressBar.value = OxygenManager.get_max_oxygen()

