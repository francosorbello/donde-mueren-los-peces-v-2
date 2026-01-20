extends Resource
class_name UserSettings

@export var window_mode : int = DisplayServer.WINDOW_MODE_FULLSCREEN
@export var volumes : Dictionary[String,float] = {
	"Master": 1,
	"Music": 1,
	"SFX": 1  
}

func save():
	ResourceSaver.save(self,"user://user_settings.tres")

static func load_or_create() -> UserSettings:
	var res = load("user://user_settings.tres") as UserSettings
	if not res:
		print("settings save not found. creating new one")
		res = UserSettings.new()
	
	return res

func apply_settings():
	print("applying user settings")
	DisplayServer.window_set_mode(window_mode)
	
	for bus in volumes:
		# print("Setting bus %s (%d) to volume %f"%[bus,AudioServer.get_bus_index(bus),volumes[bus]])
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(bus),
			linear_to_db(volumes[bus])
		)

func set_volume_for(bus_name : String, value : float):
	assert(volumes.has(bus_name), "No volume named %s"%bus_name)
	assert(value >= 0 and value <= 1,"Volume must be between 0 and 1")

	volumes[bus_name] = value
	save()

func set_window_mode(new_mode : int):
	window_mode = new_mode
	save()

func dump_save():
	var save_copy = self.duplicate()
	var save_path = "res://tests/save_dumps/settings.res"
	var result = ResourceSaver.save(save_copy,save_path)
	if result == OK:
		Console.print_line("Dumped save %s to path %s"%["settings",save_path])
	else:
		Console.print_error("Could not dump save")
