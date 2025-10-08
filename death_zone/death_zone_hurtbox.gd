extends Area2D

@export var coyote_time : float = 0.5
@export var disabled : bool = false

signal entered_death_zone

var _col_shape : CollisionShape2D

func _on_area_entered(area: Area2D) -> void:
    if disabled: 
        return
    
    if area.get_parent() is DeathZone:
        if coyote_time == 0:
            entered_death_zone.emit()
        else:
            $CoyoteTimeTimer.start(coyote_time)


func _on_coyote_time_timer_timeout() -> void:
    if disabled: 
        return

    var areas = get_overlapping_areas()
    
    for area in areas:
        if area.get_parent() and area.get_parent() is DeathZone:
            entered_death_zone.emit()
            return

func toggle_active(to_value : bool):
    if disabled: 
        return

    if not _col_shape:
        for child in get_children():
            if child is CollisionShape2D:
                _col_shape = child
                break
    
    _col_shape.set_deferred("disabled", not to_value)
    # _col_shape.disabled = !to_value