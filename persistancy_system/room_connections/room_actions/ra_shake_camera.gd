extends RoomAction
class_name RoomActionShakeCamera

@export var shake_duration : float = 1

var camera : Camera2D
var shake_component : CameraShakeComponent

func use():
	if not camera:
		camera = Camera2D.new()
		camera.limit_enabled = true
		camera.limit_left = -10
		camera.limit_top = -10
		camera.limit_right = 298
		camera.limit_bottom = 280
		camera.position = Vector2(144,135)
		add_child(camera)

	if not shake_component:
		shake_component = CameraShakeComponent.new()
		add_child(shake_component)
	
	shake_component.start_shake(camera,shake_duration)
