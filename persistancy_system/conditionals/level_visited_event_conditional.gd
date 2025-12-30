extends PersistentEventConditional
class_name LevelVisitedEventConditional

@export var level_visited : String

func evaluate(_cached_events : Dictionary[String,float] = {}) -> bool:
    var save : ASavedGame = SaveUtils.get_save()
    if save:
        return save.visited_levels.has(level_visited)
    
    return false
