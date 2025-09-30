extends Resource
class_name AbilityData

@export var state_name : String
@export var cost : int = 10:
    set(value):
        if value < 0:
            value = 0
        
        cost = value

func execute(_player : APlayer):
    pass