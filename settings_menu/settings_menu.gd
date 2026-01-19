extends Control

func _ready():
    $TabContainer/Game/GridContainer/WindowOptions.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
    var input_handled : bool = false
    if event.is_action_pressed("tab_left"):
        tab_to_left()
        input_handled = true
    
    if event.is_action_pressed("tab_right"):
        tab_to_right()
        input_handled = true

    if event.is_action_pressed("ui_cancel"):
        hide()
        input_handled = true
    
    if input_handled:
        get_viewport().set_input_as_handled()

func tab_to_left():
    var current_pos = $TabContainer.current_tab
    
    current_pos -= 1
    if current_pos < 0:
        current_pos = $TabContainer.get_tab_count() - 1
    
    $TabContainer.current_tab = current_pos

func tab_to_right():
    var current_pos = $TabContainer.current_tab
    
    current_pos += 1
    if current_pos >= $TabContainer.get_tab_count():
        current_pos = 0
    
    $TabContainer.current_tab = current_pos


func _on_tab_container_tab_changed(tab: int) -> void:
    await get_tree().process_frame
    match tab:
        0:
            print("should grab focus, no?")
            $TabContainer/Game/GridContainer/WindowOptions.grab_focus()


func _on_visibility_changed() -> void:
    if visible:
        $TabContainer.current_tab = 0