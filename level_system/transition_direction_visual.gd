@tool
extends Node2D

@export var length : float = 12:
    set(value):
        length = value
        if Engine.is_editor_hint():
            queue_redraw()
@export_tool_button("Redraw") var redraw_action = queue_redraw
var direction : int
const head_size = 20.0
const head_ang = 0.3 #rad

func _ready():
    visible = Engine.is_editor_hint()
    if visible:
        queue_redraw()

func _process(_delta: float) -> void:
    if Engine.is_editor_hint():
        var new_dir = get_parent().direction
        if new_dir != direction:
            direction = new_dir
            queue_redraw()

func _draw() -> void:
    if not Engine.is_editor_hint():
        return

    var dir = _transition_direction_to_vector(direction)
    draw_line(Vector2.ZERO,dir * length,Color.YELLOW,3)
    draw_arrow(self,dir * length,dir * length * 4, Color.YELLOW,3,true,head_size,head_ang)

func _transition_direction_to_vector(dir : int) -> Vector2:
    match dir:
        0:
            return Vector2.UP
        1:
            return Vector2.DOWN
        2:
            return Vector2.LEFT
        3:
            return Vector2.RIGHT

    return Vector2.ZERO

static func draw_arrow(node: Node2D, origin: Vector2, target: Vector2, color: Color, width: float = -1, filled: bool = false, head_length: float = 2.5, head_angle: float = PI / 4.0) -> void:
    target -= origin * 2
    var head: Vector2 = -target.normalized() * head_length
    var end = -target.normalized() * head_length / 2 + target + origin
    target += origin
    var head_right = target + head.rotated(head_angle)
    var head_left = target + head.rotated(-head_angle)

    if filled:
        node.draw_line(origin, end, color, width)
        node.draw_colored_polygon([head_right, target, head_left], color)
    else:
        node.draw_line(origin, target , color, width)
        node.draw_polyline([head_right, target , head_left], color, width)