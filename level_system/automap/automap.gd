extends Control

@onready var graph : GraphEdit = $GraphEdit

var visuals : Array[GraphElement]

var _current_level : String

var _screen_center : Vector2

var _test_visual : Control

func _ready() -> void:
	GlobalSignal.level_entered.connect(_on_level_entered)
	for child in graph.get_children():
		if child is GraphElement:
			visuals.append(child)
	
	_screen_center.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	_screen_center.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	_screen_center = _screen_center/2

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
		GlobalSignal.game_ui_closed.emit()
	else:
		show_map()

func show_map():
	var visible_levels = get_visible_levels()
	print(visible_levels)
	for visual in visuals:
		if not visual.visible:
			visual.show_visual(visible_levels)

		if visual.level_id == _current_level:
			# center_on_visual(visual)
			center_on_node($GraphEdit,visual)
			visual.toggle_current(true)
		else:
			visual.toggle_current(false)
	show()
	GlobalSignal.game_ui_opened.emit()

func get_visible_levels() -> Array[String]:
	var saved_game = IndieBlueprintSaveManager.current_saved_game as ASavedGame
	if saved_game:
		return saved_game.visited_levels
	
	return []

func _on_level_entered(id : String):
	_current_level = id

func center_on_visual(visual : GraphElement):
	_test_visual = visual
	var offset_required = _screen_center - position - visual.get_center_point()
	$GraphEdit.scroll_offset = offset_required
	queue_redraw()

func center_on_node(graph_edit: GraphEdit, node: GraphElement) -> void:
	var node_pos = node.position_offset
	var node_size = node.size
	var graph_size = graph_edit.size

	var node_center = node_pos + node_size / 2.0
	
	var target_scroll = node_center - graph_size / 2.0 
	graph_edit.scroll_offset = target_scroll / graph_edit.zoom
