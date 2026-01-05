extends Node

@export var pickable_item : Node2D

func _ready():
	pickable_item.picked_up.connect(func(_item):
		GlobalData.main_screen_manager.transition_to("EndDemo")    
	)
