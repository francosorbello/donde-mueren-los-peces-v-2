extends Node2D

@export var hide_platform_time : float = 0.5

func _on_bridge_crossed_evaluator_succeded() -> void:
    queue_free()
    pass # Replace with function body.

func _on_jump_ability_picked_up_evaluator_evaluator_succeded() -> void:
    $DestroyWhenExitedArea.set_deferred("monitoring",false)
    $DestroyWhenExitedArea/CollisionShape2D.set_deferred("disabled",true)
    do_destroy.call_deferred()
    # queue_free()


@warning_ignore("unused_parameter")
func _on_platform_area_body_exited(body: Node2D) -> void:
    pass
    # if body is APlayer and body.global_position.x < global_position.x:
    #     $DestroyWhenExitedArea.set_deferred("monitoring",false)
    #     $DestroyWhenExitedArea/CollisionShape2D.set_deferred("disabled",true)
    #     do_destroy.call_deferred()

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
            hide()
            PersistencySystem.set_event("bridge_to_jump_crossed",1.0)
        )

func hide_platform_anim(platform_sprite : Sprite2D, time : float) -> Tween:
    var tween := create_tween()

    tween.tween_property(platform_sprite,"modulate",Color(0,0,0,0),time)

    return tween

