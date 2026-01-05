extends CutsceneAction

func do_action():
    GlobalData.main_screen_manager.transition_to("EndDemo")
