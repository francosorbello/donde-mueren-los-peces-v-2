extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

@export var soften_color : Color

@export_category("Abilities")
@export_flags_2d_physics var jump_collision_mask : int
@export var abilities : Array[AnItem]

var last_direction : Vector2

var _initial_collision_mask : int

var _start_pos

var extra_velocity : Vector2

func _ready():
	_initial_collision_mask = collision_mask
	_start_pos = global_position

	GlobalSignal.game_ui_opened.connect(_on_ui_opened)
	GlobalSignal.game_ui_closed.connect(_on_ui_closed)
	var saved_game = SaveUtils.get_save()
	if saved_game:
		abilities = saved_game.unlocked_abilities

func _unhandled_input(event):
	# if event.is_action_pressed("shoot_bubble"):
	# 	$StateMachine.transition_to("ShootingBubbleState")
	# 	return

	if event.is_action_pressed("interact"):
		$BetterInteractableManager.use_interactable()
	
	# if event.is_action_pressed("attack"):
	# 	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	# 	direction = (get_global_mouse_position()-global_position).normalized()
	# 	if direction == Vector2.ZERO:
	# 		direction = last_direction
	# 	$SlashAttack.do_attack(direction)
	# 	return

	# if event.is_action_pressed("use_ability") and $StateMachine.current_state.name != "ShootingBubbleState":
	# 	current_ability.execute(self)
	# 	return

	if event.is_action_pressed("jump") and has_ability_named("jump") and $StateMachine.current_state.name != "JumpingState":
		$StateMachine.transition_to("JumpingState")

func play_anim(anim_name : String):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)

func soften_sprite(do_soften : bool):
	var tween := create_tween()
	var col = Color.WHITE
	if do_soften:
		col = soften_color

	tween.tween_property($Sprite2D,"modulate",col,0.2)

func get_bubble_sprite() -> Sprite2D:
	return $BubbleSprite

func start_jump():
	collision_mask = jump_collision_mask
	pass

func stop_collision():
	collision_mask = _initial_collision_mask

func use_explosion_ability():
	$ExplosionAbility.do_explosion()

func attach_to_air_current(path_to_follow : AirCurrentFollower):
	$StateMachine.send_message_to("OnAirCurrentState",{"path_to_follow": path_to_follow})
	$StateMachine.transition_to("OnAirCurrentState")

func detach_from_air_current():
	if $StateMachine.current_state.name == "OnAirCurrentState":
		$StateMachine.transition_to("JumpingState")

func add_extra_velocity(vel : Vector2, time : float):
	extra_velocity = vel
	get_tree().create_timer(time).timeout.connect(func():
		extra_velocity = Vector2.ZERO
	)

func has_ability_named(ab_name : String) -> bool:
	var lowercase_name = ab_name.to_lower()

	for ability in abilities:
		if ability.item_name.to_lower() == lowercase_name:
			return true

	return false

func _on_floor_detection_component_player_fell() -> void:
	$DeadAnimPlayer.play_anim($Sprite2D)
	global_position = $SafePointManager.last_safe_position

func _on_ui_opened():
	$StateMachine.transition_to("EmptyState")

func _on_ui_closed():
	$StateMachine.transition_to("IdleState")