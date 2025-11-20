@tool
extends Line2D

@export var end_point : Vector2
@export var number_of_points : int = 5

@export_category("Animation")
@export var offset : float = 5
@export var anim_time : float = 0.1
@export var ignore_extreme_points : bool = false

@export_category("Debug")
@export_tool_button("Create") var create_action = create
@export_tool_button("Start anim") var start_anim_action = start_anim
@export_tool_button("Stop anim") var stop_anim_action = stop_anim

var anim_active : bool = false
var _acc_time : float = 0

var original_points : Array
var line_dir : Vector2

func create():
    if end_point == Vector2.ZERO:
        points = []
        return

    var start_point = Vector2.ZERO
    var final_point = end_point

    var new_points = [start_point]

    for i in range(1, number_of_points + 1):
        var t = float(i) / float(number_of_points + 1)  # Calculate interpolation factor
        var interpolated_point = start_point.lerp(final_point, t)
        new_points.append(interpolated_point)

    new_points.append(end_point)

    points = new_points
    original_points = new_points
    line_dir = (end_point - start_point).normalized()

func start_anim():
    anim_active = true

func stop_anim():
    anim_active = false
    points.clear()
    points = original_points

func _process(delta):
    if points.is_empty() or not anim_active:
        return
    
    _acc_time += delta
    
    if _acc_time < anim_time:
        return

    var dir = Vector2(line_dir.y,-line_dir.x)
    var from = 0
    var to = points.size()
    
    if ignore_extreme_points:
        from = 1
        to -= 1

    for i in range(from, to):
        set_point_position(i,original_points[i]+dir * randf_range(-offset,offset))
    
    _acc_time = 0
