extends Node2D

@export var breakable : bool = false
@export var time_between_broken_states : float = 1
@export var time_disabled : float = 2


var _max_states : int
var _current_state : int = 0
var _breaking : bool = false

func _ready() -> void:
    _max_states = $BreakableSprite2D.hframes

func _on_platform_area_body_entered(body: Node2D) -> void:
    if not breakable:
        return

    if body is APlayer and not _breaking:
        _start_breaking()

func _start_breaking():
    _breaking = true
    $BetweenStatesTimer.start(time_between_broken_states)
    $BreakableSprite2D/SpriteShaker.start_shake(5,5)

func _on_between_states_timer_timeout() -> void:
    if _current_state >= _max_states:
        _temp_disable()
        return

    $BreakableSprite2D.frame = _current_state
    _current_state += 1
    $BetweenStatesTimer.start(time_between_broken_states)

func _temp_disable():
    $CPUParticles2D.restart()
    _anim_platform_to(0.0)
    $DisabledTimer.start(time_disabled)
    $PlatformArea.toggle_active(false)

func _restart():
    _breaking = false
    _current_state = 0
    $BreakableSprite2D.frame = 0
    $PlatformArea.toggle_active(true)
    _anim_platform_to(1.0)

func _anim_platform_to(max_value : float):
    var tween := create_tween()

    tween.tween_property($BreakableSprite2D,"modulate:a",max_value,0.5)

func _disabled_timer_timeout():
    _restart()
