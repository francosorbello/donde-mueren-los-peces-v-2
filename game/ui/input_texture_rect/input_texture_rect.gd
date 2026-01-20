extends TextureRect

@export var action_name : String

func _ready():
	InputHelper.device_changed.connect(_on_input_device_changed)
	_on_input_device_changed(InputHelper.guess_device_name(),0)

func _on_input_device_changed(device: String, _device_index: int) -> void:
	if device == InputHelper.DEVICE_KEYBOARD:
		return
	else:
		if InputUtils.is_playstation_gamepad(device):
			update_texture("ps")
		else:
			update_texture("xbox")

func update_texture(device : String):
	var path = get_path_to_texture(device)
	
	var tex = load(path) as Texture
	assert(tex, "Texture for action %s on device %s not found"%[action_name,device])

	texture = tex


func get_path_to_texture(device : String) -> String:
	return "res://assets/GRAPHICS/inputs/hi_res/%s/%s.png"%[device,action_name]
