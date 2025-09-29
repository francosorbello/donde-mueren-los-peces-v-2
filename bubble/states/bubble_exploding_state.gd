extends BubbleState

@export var explosion_visual : Node2D
@export var collision_shape : CollisionShape2D

func enter():
    bubble.get_node("DeadTimer").stop()
    var hurtbox = bubble.get_node("ExplosionHurtbox") as Hurtbox
    
    show_area_visual()
    await get_tree().create_timer(0.4).timeout
    explosion_visual.hide()

    hurtbox.enable()
    
    $Timer.start(0.2)
    await $Timer.timeout
    
    hurtbox.disable()
    
    bubble.pop()

func show_area_visual():
    var shape = collision_shape.shape
    if shape.radius:
        explosion_visual.radius = shape.radius
        explosion_visual.show()