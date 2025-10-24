extends Area2D
class_name PlatformArea

func toggle_active(is_active : bool,use_deferred : bool = false):
    print("toggle platform to: ",is_active)
    monitoring = is_active
    monitorable = is_active
    for child in get_children():
        if child is CollisionShape2D:
            if use_deferred:
                child.set_deferred("disabled",not is_active)
            else:
                child.disabled = not is_active
    visible = is_active


