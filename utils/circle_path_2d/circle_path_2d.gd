@tool
extends Path2D

@export var size : float = 10:
    set(value):
        size = value
        if Engine.is_editor_hint() and is_node_ready():
            create()
@export var num_points : int = 32:
    set(value):
        num_points = value
        if Engine.is_editor_hint() and is_node_ready():
            create()

func _ready() -> void:
    if Engine.is_editor_hint():
        create()

func create() -> void:
    curve = Curve2D.new()
    
    for i in range(0,num_points):
        curve.add_point(Vector2(0, -size).rotated((i / float(num_points)) * TAU))

    curve.add_point(Vector2(0,-size))

