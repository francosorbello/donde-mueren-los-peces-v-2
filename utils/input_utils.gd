extends Object
class_name InputUtils

static func is_xbox_gamepad(device_name : String):
    device_name = device_name.to_lower()
    return "xbox" in device_name

static func is_playstation_gamepad(device_name : String):
    device_name = device_name.to_lower()
    return "playstation" in device_name



