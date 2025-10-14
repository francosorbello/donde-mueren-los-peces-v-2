extends Control

var item : AnItem:
    set(value):
        item = value
        if item:
            set_icon(item.icon)

func _ready():
    focus_entered.connect(_on_focus)
    focus_exited.connect(_on_focus_lost)
    _on_focus_lost()

func _on_focus():
    $TextureRect.modulate = Color.WHITE

func _on_focus_lost():
    $TextureRect.modulate = Color(1,1,1,0.6)

func set_icon(icon : Texture2D):
    $TextureRect.texture = icon