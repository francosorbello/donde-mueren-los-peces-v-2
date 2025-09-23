extends Node

enum GameEvent
{
    GE_DEFAULT
}

enum ExecutionType
{
    ET_DEFERRED,
    ET_INMEDIATE,
}

class GESuscriber:
    var owner : Node
    var function_name : String

    func is_valid() -> bool:
        return owner != null and owner.has_method(function_name)
    
    func execute(event, message : Dictionary = {}, execution_type : ExecutionType = ExecutionType.ET_DEFERRED):
        match execution_type:
            ExecutionType.ET_DEFERRED:
                owner.call_deferred(function_name, event, message)
            ExecutionType.ET_INMEDIATE:
                owner.call(function_name, event, message)
            _:
              push_warning("Execution type doesnt exist when trying to execute %s for event %s"%[function_name,event])  

var suscribers : Array

func suscribe(node : Node, function_name : String):
    var suscriber = GESuscriber.new()
    suscriber.owner = node
    suscriber.function_name = function_name
    
    suscribers.append(suscriber)

func emit(event : GameEvent, message : Dictionary = {}, execution_type : ExecutionType = ExecutionType.ET_DEFERRED):
    for suscriber : GESuscriber in suscribers:
        if suscriber.is_valid():
            suscriber.execute(event,message)

func unsuscribe(node : Node):
    for suscriber in suscribers:
        if suscriber.owner == node:
            suscribers.erase(suscriber)
            return