@tool
extends PolygonCurve2D

var path_to_follow : PathFollow2D

func _ready() -> void:
	super()

	if Engine.is_editor_hint(): return
	if collision_area:
		collision_area.area_entered.connect(_on_area_entered)
		collision_area.body_entered.connect(_on_body_entered)
		collision_area.body_exited.connect(_on_body_exited)
		
	for child in get_children():
		if child is PathFollow2D:
			path_to_follow = child

func spawn_required_children():
	super()
	path_to_follow = PathFollow2D.new()
	add_child(path_to_follow)
	path_to_follow.name = "PathFollow2D"
	path_to_follow.owner = get_tree().edited_scene_root 

func _on_body_entered(body : Node2D):
	print(body)
	if not path_to_follow:
		push_error("No path follower on air current %s"%name)

	if body is APlayer:
		body.attach_to_air_current(path_to_follow)

func _on_body_exited(body : Node2D):
	print("deatch")
	if body is APlayer:
		body.detach_from_air_current()

func _on_area_entered(area : Area2D):
	if not path_to_follow:
		push_error("No path follower on air current %s"%name)

	if area.get_parent() and area.get_parent() is APlayer:
		area.get_parent().attach_to_air_current(path_to_follow)
