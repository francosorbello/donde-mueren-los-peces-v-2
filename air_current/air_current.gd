@tool
extends PolygonCurve2D

@export var disabled_time : float = 1

var path_to_follow : AirCurrentFollower

var enabled : bool = true

func _ready() -> void:
	super()

	if Engine.is_editor_hint(): 
		return
	
	if collision_area:
		collision_area.area_entered.connect(_on_area_entered)
		collision_area.body_entered.connect(_on_body_entered)
		collision_area.body_exited.connect(_on_body_exited)
		
	for child in get_children():
		if child is AirCurrentFollower:
			path_to_follow = child
			path_to_follow.finished_path.connect(_on_path_finished)

func _on_path_finished():
	enabled = false
	collision_polygon.disabled = true

	await get_tree().create_timer(disabled_time).timeout
	
	enabled = true
	collision_polygon.disabled = false

func spawn_required_children():
	super()

	path_to_follow = AirCurrentFollower.new()
	add_child(path_to_follow)
	
	path_to_follow.rotates = false
	path_to_follow.name = "AirCurrentFollower"
	path_to_follow.owner = get_tree().edited_scene_root 

func _on_body_entered(body : Node2D):
	if not enabled:
		return

	if not path_to_follow:
		push_error("No path follower on air current %s"%name)

	if body is APlayer:
		body.attach_to_air_current(path_to_follow)

func _on_body_exited(body : Node2D):
	if not enabled:
		return
	if body is APlayer:
		body.detach_from_air_current()

func _on_area_entered(area : Area2D):
	if not enabled:
		return
	if not path_to_follow:
		push_error("No path follower on air current %s"%name)

	if area.get_parent() and area.get_parent() is APlayer:
		area.get_parent().attach_to_air_current(path_to_follow)
