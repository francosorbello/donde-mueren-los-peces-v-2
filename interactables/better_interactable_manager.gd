# @tool
extends Node2D

@export var radius : float = 20:
	set(value):
		radius = value
		if Engine.is_editor_hint() and debug_draw:
			queue_redraw()

@export var debug_draw : bool = false:
	set(value):
		debug_draw = value
		if Engine.is_editor_hint():
				queue_redraw()
			
@export var refresh_time : float = 0.5

var scene_interactables : Array[BetterInteractableComponent]
var current_interactable : BetterInteractableComponent

func _ready() -> void:
	if Engine.is_editor_hint(): return

	await get_tree().process_frame
	var nodes_found = get_tree().get_nodes_in_group("interactable")
	for node in nodes_found:
		if node is BetterInteractableComponent:
			scene_interactables.append(node)

	if scene_interactables.is_empty():
		return
		
	$RefreshTimer.start(refresh_time)
	

# func _physics_process(_delta):
#     if Engine.is_editor_hint():
#         return

#     if scene_interactables.is_empty():
#         return

#     refresh_interactable()


func refresh_interactable():
	var new_interactable = null
	var new_interactable_distance :float = 100000000

	for interactable in scene_interactables:
		if not is_instance_valid(interactable):
			continue
		var dist = interactable.global_position.distance_to(global_position)
		if dist < radius and dist < new_interactable_distance:
			new_interactable = interactable
			new_interactable_distance = dist

	if new_interactable and new_interactable != current_interactable:
		switch_to(new_interactable)

func switch_to(interactable : BetterInteractableComponent):
	if current_interactable:
		current_interactable.leave_interactable()
	current_interactable = interactable
	current_interactable.hover_interactable()

func use_interactable():
	if current_interactable:
		current_interactable.interact()

func _draw() -> void:
	# if Engine.is_editor_hint() and debug_draw:
	if debug_draw:
		draw_circle(Vector2.ZERO,radius, Color.WHITE)

func _on_refresh_timer_timeout() -> void:
	if current_interactable and current_interactable.global_position.distance_to(global_position) > radius:
		current_interactable.leave_interactable()
		current_interactable = null
	refresh_interactable()
	pass # Replace with function body.

