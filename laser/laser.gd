@tool
extends Node2D

enum LaserDirection {
    HORIZONTAL,
    VERTICAL
}
@export var direction : LaserDirection
@export var end_point : float:
    set(value):
        end_point = value
        if Engine.is_editor_hint():
            queue_redraw()

@export var width : float = 10:
    set(value):
        width = value
        if Engine.is_editor_hint():
            queue_redraw()

@export_category("Time related")
@export var inactive_duration : float = 3
@export var charging_duration : float = 2
@export var active_duration : float = 3

func _ready() -> void:
    if Engine.is_editor_hint():
        return
    
    setup()

func setup():
    prints("start setup",end_point)
    if end_point == 0:
        return

    var p0 = Vector2.ZERO
    var p1 = _get_end_point()

    var points = [p0,p1]

    $LaserLine.points = points
    $LaserLine.width = width
    # $LaserLine.visible = false

    $IndicatorLine.points = points
    $IndicatorLine.width = width

    var rect_shape = RectangleShape2D.new()
    var size : Vector2
    if direction == LaserDirection.HORIZONTAL:
        size = Vector2(abs(end_point),width)
    else:
        size = Vector2(width, abs(end_point))
    
    rect_shape.size = size

    $Hurtbox/CollisionShape2D.shape = rect_shape
    $Hurtbox/CollisionShape2D.position = _get_end_point()/2
    $Hurtbox.disable()

func _draw() -> void:
    if Engine.is_editor_hint():
        draw_line(Vector2.ZERO,_get_end_point(),Color(1,.4,1,0.4), width)

func _get_end_point() -> Vector2:
    if direction == LaserDirection.HORIZONTAL:
        return Vector2(end_point,0)
    else:
        return Vector2(0,end_point)