extends Node2D

@export var hide_platform_time : float = 0.5

func _on_persistent_event_evaluator_evaluator_succeded() -> void:
    queue_free()
    pass # Replace with function body.

func _on_platform_area_body_exited(body: Node2D) -> void:
    print("body exited")
    if body is APlayer:
        $DestroyWhenExitedArea.set_deferred("monitoring",false)
        $DestroyWhenExitedArea/CollisionShape2D.set_deferred("disabled",true)
        do_destroy.call_deferred()

func do_destroy():
    $PlatformArea.toggle_active(false,true)
    var i := 1
    var last_tween : Tween
    for child in get_children():
        if child is Sprite2D:
            last_tween = hide_platform_anim(child,hide_platform_time*i)
            i += 1 

    if last_tween:
        last_tween.finished.connect(func():
            PersistencySystem.set_event("bride_to_jump_crossed",1.0)
        )

func hide_platform_anim(platform_sprite : Sprite2D, time : float) -> Tween:
    var tween := create_tween()

    tween.tween_property(platform_sprite,"modulate",Color(0,0,0,0),time)

    return tween