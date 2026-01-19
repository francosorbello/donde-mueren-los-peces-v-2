extends HSlider

@export var bus_name : String

var bus_id : int

func _ready():
    await get_tree().process_frame
    bus_id = AudioServer.get_bus_index(bus_name)
    set_value_no_signal(AudioServer.get_bus_volume_linear(bus_id))

func _on_value_changed(_value: float) -> void:
    AudioServer.set_bus_volume_db(bus_id, linear_to_db(_value))
    
    GlobalData.user_settings.set_volume_for(bus_name,_value)
