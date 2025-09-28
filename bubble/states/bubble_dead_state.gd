extends BubbleState

func enter():
    bubble.get_node("DeadTimer").stop()
    bubble.popped.emit(bubble)
    var anim_player = bubble.get_anim_player()
    anim_player.play("pop")
    await anim_player.animation_finished
    bubble.queue_free()

