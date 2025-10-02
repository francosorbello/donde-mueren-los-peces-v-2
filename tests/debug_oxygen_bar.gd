extends Control

func _ready():
    start()
    OxygenManager.oxygen_depleted.connect(_on_oxygen_changed)
    OxygenManager.oxygen_restored.connect(_on_oxygen_changed)

func _on_oxygen_changed(_value):
    var tween := create_tween()
    tween.tween_property($ProgressBar,"value",OxygenManager.current_oxygen,0.1)
    # $ProgressBar.value = OxygenManager.current_oxygen

func start():
    $ProgressBar.value = OxygenManager.get_max_oxygen()

