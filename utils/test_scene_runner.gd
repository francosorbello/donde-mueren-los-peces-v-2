@tool
extends EditorScript
class_name TestSceneRunner

func _run() -> void:
    EditorInterface.play_custom_scene("res://tests/style_test.tscn")
