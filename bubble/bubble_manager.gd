extends Node2D
class_name BubbleManager

@export var bubble_scene : PackedScene

var bubbles : Array[Node2D]

func shoot_bubble(from_pos : Vector2, dir:Vector2):
	if dir == Vector2.ZERO:
		return
	var bubble = bubble_scene.instantiate()
	add_child(bubble)
	bubble.global_position = from_pos
	bubble.start(dir)
	bubble.popped.connect(_on_bubble_popped)
	bubbles.append(bubble)

func _on_bubble_popped(bubble : Node):
	var index = bubbles.find(bubble)
	if index == -1:
		return
	bubbles.remove_at(index)
	bubble.queue_free()

func get_closest_to(pos : Vector2) -> Node2D:
	if bubbles.is_empty():
		return null

	var closest_dist = bubbles[0].global_position.distance_to(pos)
	var closest_bubble = bubbles[0]

	for i in range(1,len(bubbles)):
		var dist = bubbles[i].global_position.distance_to(pos)
		if dist < closest_dist:
			closest_dist = dist
			closest_bubble = bubbles[i]
	
	return closest_bubble
