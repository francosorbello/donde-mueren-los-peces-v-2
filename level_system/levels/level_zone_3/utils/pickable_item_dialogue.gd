extends Node

@export var dialogue : DialogueResource
@export var pickable_item : Node2D
@export var target : Node2D

func _ready():
    assert(pickable_item)
    assert(pickable_item.has_signal("picked_up"))
    
    pickable_item.picked_up.connect(func(_item):
        GlobalData.start_dialogue(dialogue, "start", target)    
    )
