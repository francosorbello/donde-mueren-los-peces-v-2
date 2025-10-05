extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

@export var soften_color : Color

@export_category("Abilities")
@export_flags_2d_physics var jump_collision_mask : int
@export var abilities : Array[AbilityData]
var current_ability : AbilityData

var last_direction : Vector2

var _initial_collision_mask : int

func _ready():
	current_ability = abilities[0]
	_initial_collision_mask = collision_mask

func _unhandled_input(event):
	if event.is_action_pressed("select_ability"):
		match event.as_text():
			"1":
				current_ability = abilities[0]
			"2":
				current_ability = abilities[1]
		return

	if event.is_action_pressed("shoot_bubble"):
		$StateMachine.transition_to("ShootingBubbleState")
		return

	if event.is_action_pressed("interact"):
		$BetterInteractableManager.use_interactable()
	
	if event.is_action_pressed("attack"):
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		direction = (get_global_mouse_position()-global_position).normalized()
		if direction == Vector2.ZERO:
			direction = last_direction
		$SlashAttack.do_attack(direction)
		return

	if event.is_action_pressed("use_ability") and $StateMachine.current_state.name != "ShootingBubbleState":
		current_ability.execute(self)
		return

	if event.is_action_pressed("jump") and $StateMachine.current_state.name != "JumpingState":
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

func toggle_collision(to_value : bool):
	$CollisionShape2D.disabled = !to_value

func start_jump():
	collision_mask = jump_collision_mask
	pass

func stop_collision():
	collision_mask = _initial_collision_mask