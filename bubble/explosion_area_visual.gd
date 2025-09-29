extends Node2D

@export var radius : float = 1
@export var color : Color = Color.GRAY

func _process(_delta):
    queue_redraw()

func _draw() -> void:
    draw_circle(Vector2.ZERO,radius, color,true)

