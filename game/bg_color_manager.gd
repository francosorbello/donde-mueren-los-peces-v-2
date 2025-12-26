extends ColorRect

func _ready() -> void:
    GlobalSignal.level_entered.connect(_on_level_entered)

func _on_level_entered(data : Dictionary):
    if data.has("area_type"):
        var area_type = data["area_type"]
        var new_color = GlobalData.area_bg_colors[area_type]
        color = new_color
        color.v -= 10.0/255.0
        get_parent().get_node("CenterContainer").get_node("BGColor").color = new_color