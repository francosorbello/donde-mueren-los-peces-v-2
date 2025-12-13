extends Sprite2D

@export var scale_to : float = 1.1
@export var anim_duration : float = 0.3

var jump_tween : Tween
var color_tween : Tween

func start_jump_anim(_jump_time: float):
    _play_jump_anim(scale_to,0.7)
    # _play_color_anim(Color.RED,_jump_time)

func stop_jump_anim():
    _play_jump_anim(1.0,1)
    # _play_color_anim(Color.WHITE,0.1)
    
func _play_jump_anim(anim_scale : float, _transparency : float):
    _stop_jump_tween()
    jump_tween = create_tween()

    jump_tween.set_parallel(true)
    jump_tween.tween_property(self,"scale",Vector2(anim_scale,anim_scale),anim_duration)
    # jump_tween.tween_property(self,"modulate:a",transparency,0.1)

func _stop_jump_tween():
    if jump_tween and jump_tween.is_running():
        jump_tween.kill()

func _play_color_anim(to_color : Color, duration: float):
    if color_tween and color_tween.is_running():
        color_tween.kill()
    
    color_tween = create_tween()
    color_tween.tween_property(self,"modulate",to_color,duration)