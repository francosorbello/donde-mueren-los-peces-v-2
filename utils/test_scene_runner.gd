@tool
extends EditorScript
class_name TestSceneRunner

func _run() -> void:
    EditorInterface.get_edited_scene_root()
    EditorInterface.play_custom_scene("res://tests/style_test.tscn")
