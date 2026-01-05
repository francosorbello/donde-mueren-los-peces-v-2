extends Control

@export var disabled_color : Color

func enable_jump():
    $Interactuar/Label.text= tr("UI_JUMP")