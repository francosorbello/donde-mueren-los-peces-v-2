extends HBoxContainer

@export var disabled_color : Color

func _ready():
    GlobalSignal.interactable_found.connect(enable)
    GlobalSignal.interactable_lost.connect(disable)

func enable():
    $Label.modulate = Color.WHITE
    $TextureRect.modulate = Color.WHITE

func disable():
    $Label.modulate = disabled_color
    $TextureRect.modulate = disabled_color