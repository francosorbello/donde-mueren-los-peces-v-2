extends AbilityData

func execute(player : APlayer):
    var bubble = player.bubble_manager.get_closest_to(player.global_position)
    var sm = player.get_node("StateMachine")
    if bubble:
        sm.send_message_to("DashingState",{"bubble": bubble})
        sm.transition_to("DashingState")