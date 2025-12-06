@tool
extends Node2D
class_name SimpleDoor

enum DoorType {
	HORIZONTAL,
	VERTICAL
}

@export var door_type : DoorType:
	set(value):
		door_type = value
		if self.is_node_ready():
			call_deferred("set_door_collision")

@export var start_closed : bool = true:
	set(value):
		start_closed = value

var _dissolve_material : ShaderMaterial

var disabled = false

func _ready():
	if self.is_node_ready():
		set_door_collision()

	if Engine.is_editor_hint():
		$Label.visible = not start_closed

	if not Engine.is_editor_hint():
		_duplicate_dissolve_material()
	
	if not Engine.is_editor_hint() and not start_closed:
		disabled = true
		$StaticBody2D/CollisionShape2D.disabled = true
		set_dissolve_to(1)

func set_door_collision():
	var rot = 0
	if door_type == DoorType.VERTICAL:
		rot = PI/2

	$StaticBody2D/CollisionShape2D.set_deferred("rotation",rot)

func do_toggle():
	disabled = not disabled
	$StaticBody2D/CollisionShape2D.disabled = disabled
	do_dissolve_anim()

func do_dissolve_anim():
	var tween := create_tween()
	
	var from = 0.0
	var to = 1.0
	if not disabled:
		from = 1.0
		to = 0.0

	tween.tween_method(set_dissolve_to,from,to,0.7)
	
	if disabled:
		$UnlockSound.play()

	

func _duplicate_dissolve_material():
	if $Sprite2D.material:
		_dissolve_material = $Sprite2D.material.duplicate()
		$Sprite2D.material = _dissolve_material

func set_dissolve_to(value : float):
	_dissolve_material.set_shader_parameter("progress",value)
