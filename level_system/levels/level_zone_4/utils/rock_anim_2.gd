@tool
extends Node2D

@export var scale_value : float = 4

func _ready() -> void:
    var scale_v = Vector2(scale_value,scale_value)

    $CPUParticles2D.scale = scale_v
    $Hole.scale = scale_v
    $BetterDeathZone.scale = scale_v
    pass

func play_crush_sound():
    CommonSfxPlayer.play_sound("rock")

func start_anim():
    await get_tree().create_timer(randf_range(0,1)).timeout
    $AnimationPlayer.play("falling_rock")
