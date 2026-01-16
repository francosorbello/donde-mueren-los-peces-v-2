extends Node2D

func _ready() -> void:
    $WC_Kai.set_interactable(false)
    $WC_Ab.set_interactable(false)

    $WC_Kai.move_to($TargetPos.global_position)
    $WC_Ab.move_to($TargetPos.global_position)


