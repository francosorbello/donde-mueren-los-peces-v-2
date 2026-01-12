extends CutsceneAction

@export var camera_scene : PackedScene

func do_action():
    var camera_instance = camera_scene.instantiate()
    add_child(camera_instance)
    camera_instance.position = Vector2(144,135)