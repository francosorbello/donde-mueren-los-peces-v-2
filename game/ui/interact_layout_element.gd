extends HBoxContainer

@export var disabled_color : Color

func _ready():
    GlobalSignal.interactable_found.connect(enable)
    GlobalSignal.interactable_lost.connect(disable)

func enable():
    print("Enable")
    $Label.modulate = Color.WHITE
    $TextureRect.modulate = Color.WHITE

func disable():
    print("Disable")
    $Label.modulate = disabled_color
    $TextureRect.modulate = disabled_color