extends Control

func _ready():
    GlobalSignal.level_entered.connect(func(data):
        if data.has("level_name"):
            $Label.text = data["level_name"]
        else:
            "Unknown level"
    )
    
