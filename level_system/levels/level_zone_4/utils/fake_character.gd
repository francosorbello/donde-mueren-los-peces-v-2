extends Sprite2D

@export var pitch_scale : float = 1
@export var target : Marker2D

func _ready():
    $StepSounds.pitch_scale = pitch_scale
    assert(target)

func start_movement():
    $MoveComponent.move_to(target.global_position)