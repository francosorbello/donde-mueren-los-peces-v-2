extends PathFollow2D

var player : APlayer

var moving : bool = false
var speed : float
var from_start : bool

func start(at_speed : float,from_start_point : bool = true):
    player = get_player()
    if player:
        moving = true
        speed = at_speed
        from_start = from_start_point
        if from_start:
            progress_ratio = 0
        else:
            progress_ratio = 1
        player.attach_to_railway()
        $RemoteTransform2D.remote_path = player.get_path()

func stop():
    if player:
        moving = false
        $RemoteTransform2D.remote_path = ""
        var mod = 1 if from_start else -1
        player.detach_from_railway(get_parent().direction * mod)

func _process(delta):
    if not moving:
        return
    
    if from_start:
        progress += delta * speed
        if progress_ratio >= 1:
            stop()
    else:
        progress -= delta * speed
        if progress_ratio <= 0:
            stop()

func get_player():
    if player:
        return player
    
    return get_tree().get_first_node_in_group("player")

