class_name State extends Node
## State for a state machine.
##  
## Particular implementations of states inherit from this class, implementing the required functionality. [br]
## They have to be parented to a [class StateMachine] to be able to access them.

var state_machine: StateMachine = null ## Machine this state belongs to.
var state_owner: Node = null ## Owner of the state machine.

## Setup a state.
## [br]
## [param s_owner] : Owner of the state machine. [br]
## [param s_machine] : State Machine this state belongs to.
func setup(s_owner: Node, s_machine: StateMachine):
	self.state_machine = s_machine
	self.state_owner = s_owner

## Enter the state.
func enter():
	pass

## Update the state.
func update(delta: float):
	pass

## Update the state on the physics stage.
func physics_update(delta: float):
	pass

## Exit the stage.
func exit():
	pass

## Indicates if you can exit a state or not.
func can_exit() -> bool:
	return true

func receive_message(message : Dictionary):
	pass

func state_input(event : InputEvent):
	pass

func state_unhandled_input(event : InputEvent):
	pass