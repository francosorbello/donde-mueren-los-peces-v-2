extends Sprite2D

@export var tween_time : float = 1.5
@export var tween_distance : float = 10
var tween : Tween

func _ready() -> void:
    tween = create_tween()
    # tween.tween_property($Sprite2D,"scale:x",-1,tween_time)
    # tween.tween_property($Sprite2D,"scale:x",1,tween_time)
    tween.tween_property(self,"position:y",-tween_distance,tween_time)
    tween.tween_property(self,"position:y",0,tween_time) 
    tween.set_loops()

