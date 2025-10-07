class_name StateMachine extends Node
## Implementation of a state machine.
##
## Each state is a separate node that is parented to this node. Transitions are done by the name of the node. [br]
## For example, if your [class State] node is called "DiveState", transitioning to that node would look as: 
## [codeblock]
## func do_dive():
## 	transition.to("DiveState")
## [/codeblock]


@export var initial_state : State ## State the machine starts on.

var current_state : State

signal switched_states(from : String, to : String)

func _ready():
	await owner.ready

	for child_state : State in get_children():
		child_state.setup(get_parent(),self)

	current_state = initial_state
	current_state.enter()

## Transition to a new state.
## [br]
## [param target_state_name] : Name of the state.
func transition_to(target_state_name: String):
	if(not current_state.can_exit()):
		return
		
	if not has_node(target_state_name):
		print("No state named %s"%target_state_name)
		return

	var prev_state_name = current_state.name
	
	current_state.exit()
	current_state = get_node(target_state_name)
	current_state.enter()
	
	switched_states.emit(prev_state_name, target_state_name)

func send_message_to(state_name : String, message : Dictionary):
	if has_node(state_name):
		get_node(state_name).receive_message(message)

func _process(delta):
	current_state.update(delta)   

func _physics_process(delta):
	current_state.physics_update(delta)

func _input(event):
	current_state.state_input(event)

func _unhandled_input(event):
	current_state.state_unhandled_input(event)
