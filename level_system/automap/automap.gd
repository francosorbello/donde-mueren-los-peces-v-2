extends Control

@onready var graph : GraphEdit = $GraphEdit

var visuals : Array[GraphElement]

func _ready() -> void:
    for child in get_children():
        if child is GraphElement:
            visuals.append(child)

func _unhandled_input(event):
    if event.is_action_pressed("open_map"):
        toggle_visible()


func _process(delta):
    if visible:
        var move_dir = Input.get_vector("move_left","move_right","move_up","move_down")
        graph.scroll_offset += move_dir * delta * 300

func toggle_visible():
    if visible:
        hide()
    else:
        show_map()

func show_map():
    var visible_levels = get_visible_levels()
    for visual in visuals:
        if not visual.visible:
            visual.show_visual(visible_levels)
    
    show()

func get_visible_levels() -> Array[String]:
    var saved_game = IndieBlueprintSaveManager.current_saved_game as ASavedGame
    if saved_game:
        return saved_game.visited_levels
    
    return []