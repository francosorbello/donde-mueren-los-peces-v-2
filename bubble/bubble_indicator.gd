@tool
extends Path2D

@export_tool_button("Draw") var draw_action = draw_indicator
@export_tool_button("Clear") var clear_action = clear

@export var points : int = 10:
    set(value):
        if value < 1:
            points = 1
        else:
            points = value

@export_group("Circle")
@export_tool_button("Create circle") var create_circle_action = create_circle
@export var radius : float = 10

@export_group("Elipsis")
@export_tool_button("Create elipsis") var create_elipsis_action = create_elipsis
@export var a : float = 20
@export var b : float = 10

var _follower : PathFollow2D

func _ready():
    if Engine.is_editor_hint():
        return

    draw_indicator()
    for child in get_children():
        if child is PathFollow2D:
            _follower = child
            return

func set_direction(direction : Vector2):
    if _follower:
        _follower.progress_ratio = direction.angle()/(2*PI)
        $Follower/Arrow.rotation = direction.angle()
func clear():
    curve = null
    draw_indicator()

func draw_indicator():
    if not curve:
        $Line2D.points = []
        return
    if curve.point_count > 0:
        $Line2D.points = curve.get_baked_points()

func create_circle():
    var new_curve = Curve2D.new()
    var angle_size = 360.0/points

    for i in range(0,points):
        var angle = angle_size * i
        var x = radius * cos(deg_to_rad(angle))
        var y = radius * sin(deg_to_rad(angle))

        print("adding point at %s"%Vector2(x,y))
        new_curve.add_point(Vector2(x,y))
    
    curve = new_curve

func create_elipsis():
    var new_curve = Curve2D.new()
    var angle_size = 360.0/points
    var e : float = 1 - ( (b*b) / (a*a) )
    e = sqrt(e)
    for i in range(0,points):
        var angle = angle_size * i
        var r = _get_elipsis_radius(e,angle)
        var x = r * cos(deg_to_rad(angle))
        var y = r * sin(deg_to_rad(angle))

        new_curve.add_point(Vector2(x,y))
    
    curve = new_curve
    
func _get_elipsis_radius(e, angle):
    var rad_ang = deg_to_rad(angle)
    var cos_value = (1 + cos(2*rad_ang))/2
    
    var divisor = 1 - (e*e) * cos_value
    divisor = sqrt(divisor)

    return b/divisor
