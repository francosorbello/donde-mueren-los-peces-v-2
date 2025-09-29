extends CPUParticles2D

func set_as_autodelete():
    var timer = Timer.new()
    timer.one_shot = true
    add_child(timer)
    
    timer.timeout.connect(_on_autodelete_timeout)
    timer.start(lifetime + 0.2)

func _on_autodelete_timeout():
    queue_free()