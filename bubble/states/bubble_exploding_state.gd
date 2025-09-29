extends BubbleState

func enter():
    bubble.get_node("DeadTimer").stop()
    var hurtbox = bubble.get_node("ExplosionHurtbox") as Hurtbox
    
    hurtbox.enable()
    
    $Timer.start(0.2)
    await $Timer.timeout
    
    hurtbox.disable()
    
    bubble.pop()
