extends CharacterBody2D
class_name APlayer

@export var speed : float = 100
@export var accel : float = 2

@export var bubble_manager : BubbleManager

@export var soften_color : Color

@export_category("Abilities")
@export var abilities : Array[AbilityData]
var current_ability : AbilityData

var last_direction : Vector2

func _ready():
	current_ability = abilities[0]

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

func play_anim(anim_name : String):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)

func soften_sprite(do_soften : bool):
	var tween := create_tween()
	var col = Color.WHITE
	if do_soften:
		col = soften_color

	tween.tween_property($Sprite2D,"modulate",col,0.2)
