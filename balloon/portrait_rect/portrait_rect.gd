extends TextureRect

enum PortraitStatus {
    HIDDEN,
    BLURRED,
    FOCUSED
}

@export var anim_time : float = 0.5

var _current_tween : Tween

func _ready():
    visible = false

func show_portrait():
    show()
    $StateMachine.transition_to("BlurredState")

func blur_portrait():
    if not $StateMachine.current_state.name == "HiddenState":
        $StateMachine.transition_to("BlurredState")

func focus_portrait():
    if not $StateMachine.current_state.name == "HiddenState":
        $StateMachine.transition_to("FocusedState")

func hide_portrait():
    var tween = move_to_anim($StateMachine.get_node("HiddenState").hidden_position)
    tween.finished.connect(func():
        hide()    
    )

func move_to_anim(pos : Vector2, override_time : float = -1) -> Tween:
    if _current_tween and _current_tween.is_running():
        _current_tween.kill()

    _current_tween = create_tween()
        
    var time_by_dist = anim_time
    if position.distance_to(pos) < 200:
        time_by_dist = 0.25

    var time = override_time
    if time == -1:
        time = anim_time

    _current_tween.tween_property(self,"position",pos,time_by_dist)
    return _current_tween

