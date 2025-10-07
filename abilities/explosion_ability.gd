extends Node2D

@export var visual_duration : float = 0.4
@export var explosion_duration : float = 0.2

var _ability_active : bool = false

func _ready():
    $Hurtbox.disable()

func do_explosion():
    if _ability_active:
        return
    
    _ability_active = true

    show_area_visual()

    $VisualTimer.start(visual_duration)
    await $VisualTimer.timeout
    $ExplosionAreaVisual.hide_visual()

    $ExplosionSound.pitch_scale = randf_range(0.8,1.2)
    $ExplosionSound.play()

    $Hurtbox.enable()
    $AbilityTimer.start(explosion_duration)
    await $AbilityTimer.timeout
    $Hurtbox.disable()

    _ability_active = false    

func show_area_visual():
    var shape = $Hurtbox/CollisionShape2D.shape
    if shape.radius:
        $ExplosionAreaVisual.radius = shape.radius
        $ExplosionAreaVisual.show_visual()