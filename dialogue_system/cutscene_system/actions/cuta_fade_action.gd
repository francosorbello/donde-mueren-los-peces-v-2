extends CutsceneAction

enum FadeType {
    FADE_IN,
    FADE_OUT
}

@export var fade_type : FadeType = FadeType.FADE_IN

func do_action():
    var fade_rect = GlobalData.main_screen_manager.get_fade_rect()
    assert(fade_rect != null, "(%s) FadeRect not found"%name)
    match fade_type:
        FadeType.FADE_IN:
            fade_rect.fade_in()
        FadeType.FADE_OUT:
            fade_rect.fade_out()
