extends CanvasLayer
## A basic dialogue balloon for use with Dialogue Manager.

## The action to use for advancing the dialogue
@export var next_action: StringName = &"ui_accept"

## The action to use to skip typing the dialogue
@export var skip_action: StringName = &"ui_cancel"

@export_group("Templates")
@export var label_template : PackedScene
@export var responses_template : PackedScene

## The dialogue resource
var resource: DialogueResource

## Temporary game states
var temporary_game_states: Array = []

## See if we are waiting for the player
var is_waiting_for_input: bool = false

## See if we are running a long mutation and should hide the balloon
var will_hide_balloon: bool = false

## A dictionary to store any ephemeral variables
var locals: Dictionary = {}

var _locale: String = TranslationServer.get_locale()

## The current line
var dialogue_line: DialogueLine:
    set(value):
        if value:
            dialogue_line = value
            apply_dialogue_line()
        else:
            # The dialogue has finished so close the balloon
            queue_free()
    get:
        return dialogue_line

## A cooldown timer for delaying the balloon hide when encountering a mutation.
var mutation_cooldown: Timer = Timer.new()

## The base balloon anchor
@onready var balloon: Control = %Balloon

## The label showing the currently spoken dialogue
var current_dialogue_label: DialogueLabel

## The menu of responses
var responses_menu: DialogueResponsesMenu

var danger_zone_text = "Te empiezas a ahogar por la falta de aire."


var _first_appeareance_completed : bool

func _ready() -> void:
    balloon.hide()
    Engine.get_singleton("DialogueManager").mutated.connect(_on_mutated)

    # # If the responses menu doesn't have a next action set, use this one
    # if responses_menu.next_action.is_empty():
    # 	responses_menu.next_action = next_action
    mutation_cooldown.timeout.connect(_on_mutation_cooldown_timeout)
    add_child(mutation_cooldown)


func _unhandled_input(_event: InputEvent) -> void:
    # Only the balloon is allowed to handle input while it's showing
    get_viewport().set_input_as_handled()


func _notification(what: int) -> void:
    ## Detect a change of locale and update the current dialogue line to show the new language
    if what == NOTIFICATION_TRANSLATION_CHANGED and _locale != TranslationServer.get_locale() and is_instance_valid(current_dialogue_label):
        _locale = TranslationServer.get_locale()
        var visible_ratio = current_dialogue_label.visible_ratio
        self.dialogue_line = await resource.get_next_dialogue_line(dialogue_line.id)
        if visible_ratio < 1:
            current_dialogue_label.skip_typing()


## Start some dialogue
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
    temporary_game_states = [self] + extra_game_states
    is_waiting_for_input = false
    resource = _modify_dialogue(dialogue_resource)
    self.dialogue_line = await resource.get_next_dialogue_line(title, temporary_game_states)

func _modify_dialogue(dialogue : DialogueResource) -> DialogueResource:
    var new_text = dialogue.raw_text

    if new_text != dialogue.raw_text:
        return DialogueManager.create_resource_from_text(new_text)
    return dialogue

func _append_oxygen_status_to2(dialogue_resource : DialogueResource) -> DialogueResource:
        return dialogue_resource

func _append_oxygen_status_to(text : String) -> String:
    return text


func _append_player_status_to(text : String):
   return text

## Apply any changes to the balloon given a new [DialogueLine].
func apply_dialogue_line() -> void:
    mutation_cooldown.stop()

    is_waiting_for_input = false
    balloon.focus_mode = Control.FOCUS_ALL
    balloon.grab_focus()

    # character_label.visible = not dialogue_line.character.is_empty()
    # character_label.text = tr(dialogue_line.character, "dialogue")

    var new_dialogue_label = label_template.instantiate() as DialogueLabel
    new_dialogue_label.hide()
    new_dialogue_label.dialogue_line = dialogue_line
    new_dialogue_label.skipped_typing.connect(_on_skipped_typing)
    new_dialogue_label.resized.connect(_on_dialogue_control_resized)
    new_dialogue_label.spoke.connect(_on_spoken)
    %ScrollableZone.add_child(new_dialogue_label)
    current_dialogue_label = new_dialogue_label

    # fade in first appeareance
    if not _first_appeareance_completed:
        var tween = create_tween()
        $Balloon.modulate = Color(1,1,1,0)
        balloon.show()
        tween.tween_property($Balloon,"modulate",Color.WHITE,1)
        _first_appeareance_completed = true
        await tween.finished
    else:
        balloon.show()
    
    # $TypewriterSound.play()

    # Show our balloon
    will_hide_balloon = false

    current_dialogue_label.show()
    if not dialogue_line.text.is_empty():
        current_dialogue_label.type_out()
        await current_dialogue_label.finished_typing
    
    scroll_to_bottom()

    # Wait for input
    if dialogue_line.responses.size() > 0:
        var new_responses = responses_template.instantiate() as DialogueResponsesMenu
        new_responses.hide()
        %ScrollableZone.add_child(new_responses)
        new_responses.responses = dialogue_line.responses
        new_responses.response_selected.connect(_on_responses_menu_response_selected)
        balloon.focus_mode = Control.FOCUS_NONE

        balloon.focus_mode = Control.FOCUS_NONE
        new_responses.show()
    elif dialogue_line.time != "":
        var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
        await get_tree().create_timer(time).timeout
        next(dialogue_line.next_id)
    else:
        is_waiting_for_input = true
        balloon.focus_mode = Control.FOCUS_ALL
        balloon.grab_focus()


## Go to the next line
func next(next_id: String) -> void:
    self.dialogue_line = await resource.get_next_dialogue_line(next_id, temporary_game_states)

func scroll_to_bottom():
    await get_tree().process_frame
    var scroll_container = %ScrollableZone.get_parent() as ScrollContainer
    var max_scroll = scroll_container.get_v_scroll_bar().max_value
    # scroll_container.set_deferred("scroll_vertical",max_scroll)
    scroll_container.scroll_vertical = max_scroll

#region Signals

func _on_spoken(_letter: String, _letter_index: int, _speed: float):
    if $TypeSound.stream and not $TypeSound.playing:
        $TypeSound.pitch_scale = randf_range(0.7,1.3)
        $TypeSound.play()

func _on_dialogue_control_resized():
    scroll_to_bottom()
    pass

func _on_mutation_cooldown_timeout() -> void:
    if will_hide_balloon:
        will_hide_balloon = false
        balloon.hide()


func _on_mutated(_mutation: Dictionary) -> void:
    is_waiting_for_input = false
    will_hide_balloon = true
    mutation_cooldown.start(0.1)


func _on_balloon_gui_input(event: InputEvent) -> void:
    # See if we need to skip typing of the dialogue
    if current_dialogue_label.is_typing:
        var mouse_was_clicked: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
        var skip_button_was_pressed: bool = event.is_action_pressed(skip_action)
        if mouse_was_clicked or skip_button_was_pressed:
            get_viewport().set_input_as_handled()
            current_dialogue_label.skip_typing()
            return

    if not is_waiting_for_input: return
    if dialogue_line.responses.size() > 0: return

    # When there are no response options the balloon itself is the clickable thing
    get_viewport().set_input_as_handled()

    if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
        next(dialogue_line.next_id)
    elif event.is_action_pressed(next_action) and get_viewport().gui_get_focus_owner() == balloon:
        next(dialogue_line.next_id)


func _on_responses_menu_response_selected(response: DialogueResponse) -> void:
    clear_all()
    next(response.next_id)

func _on_skipped_typing():
    scroll_to_bottom()
#endregion

func clear_responses():
    for child in %ScrollableZone.get_children():
        if child is DialogueResponsesMenu:
            child.queue_free()

func clear_all():
    var clearables = %ScrollableZone.get_children()
    for child in clearables:
        child.queue_free()

