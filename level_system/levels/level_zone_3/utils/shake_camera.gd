extends DialogueCamera
class_name  ShakeDialogueCamera

@export var random_strenght : float = 1

var shake_strenght : float = 0

func _ready() -> void:
	shake_strenght = random_strenght
	super()

func _process(_delta: float) -> void:
	offset = random_offset()
	
func random_offset():
	return Vector2(
		randf_range(-shake_strenght,shake_strenght),
		0,
		)

func _handle_destroy():
	return
