extends BubbleState

func enter():
    bubble.get_node("DeadTimer").stop()