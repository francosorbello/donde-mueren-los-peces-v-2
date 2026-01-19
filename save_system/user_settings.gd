extends Resource
class_name UserSettings

@export var window_mode : int = 0
@export_range(0,1) var master_volume : float = 1
@export_range(0,1) var music_volume : float = 1
@export_range(0,1) var sfx_volume : float = 1

func save():
    ResourceSaver.save(self,"user://user_settings.tres")

static func load_or_create() -> UserSettings:
    var res = load("user://user_settings.tres") as UserSettings
    if not res:
        res = UserSettings.new()
    
    return res

func apply_settings():
    DisplayServer.window_set_mode(window_mode)
    
    set_volume_for("Master",master_volume)
    set_volume_for("Music",music_volume)
    set_volume_for("SFX",sfx_volume) 

func set_volume_for(bus_name : String, value : float):
    AudioServer.set_bus_volume_db(
        AudioServer.get_bus_index(bus_name),
        value
    )
