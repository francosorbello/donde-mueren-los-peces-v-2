extends OptionButton

enum WindowMode {
	WINDOWED = 0,
	FULLSCREEN = 1
}

func _ready():
	_set_initial_values()

func _set_initial_values():
	var window_mode = DisplayServer.window_get_mode()
	var item_to_select = _window_mode_to_item(window_mode)
	assert(item_to_select != -1)
	select(item_to_select)

func _on_item_selected(index: int) -> void:
	var window_mode = _item_to_window_mode(index)
	assert(index != -1)
	DisplayServer.window_set_mode(window_mode)
	GlobalData.user_settings.set_window_mode(window_mode)

func _window_mode_to_item(window_mode : int) -> int:
	var _value = -1
	match window_mode:
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			_value = 0
		DisplayServer.WINDOW_MODE_WINDOWED:
			_value = 1
		_:
			push_error("Missing implementation for window mode %i"%window_mode)
	
	return _value

func _item_to_window_mode(item : int) -> int:
	var _value = -1
	match item:
		0:
			_value = DisplayServer.WINDOW_MODE_FULLSCREEN
		1:
			_value = DisplayServer.WINDOW_MODE_WINDOWED
		_:
			push_error("Missing implementation for window mode %i"%item)
	
	return _value
