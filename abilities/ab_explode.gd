extends AbilityData

func execute(player : APlayer):
    var bubble = player.bubble_manager.get_closest_to(player.global_position)
    if bubble:
        bubble.explode()