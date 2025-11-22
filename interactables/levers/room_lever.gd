@tool
extends Node2D

@export var timed : bool = false
@export var timed_duration : float = 5

var activated : bool = false

var action : RoomAction:
    set(value):
        action = value
        update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
    for child in get_children():
        if child is RoomAction:
            return []

    
    return ["Room Action missing. Add one as a child."]

func _ready() -> void:
    if Engine.is_editor_hint():
        child_entered_tree.connect(_on_child_changed)
        child_exiting_tree.connect(_on_child_changed)

    for child in get_children():
        if child is RoomAction:
            action = child

func _on_better_interactable_component_on_interact() -> void:
    if action:
        action.use()
        toggle_activated()
        if timed:
            $Timer.start(timed_duration)
            $ProgressBar2D.start(timed_duration)

func _on_child_changed(_node):
    update_configuration_warnings()

func flip_sprite():
    $Sprite2D.flip_h = true

func set_activated():
    $Sprite2D.flip_h = not $Sprite2D.flip_h
    $BetterInteractableComponent.set_deferred("is_interactable",false)
    $LeverSound.play()

func toggle_activated():
    activated = not activated

    $Sprite2D.flip_h = activated
    if timed:
        $BetterInteractableComponent.set_deferred("is_interactable",not activated)
    $LeverSound.play()

func _on_timer_timeout() -> void:
    if action:
        action.use()
    toggle_activated()
