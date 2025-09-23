@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("State", "State", preload("sm/state.gd"), preload("res://icon.svg"))
	add_custom_type("StateMachine", "StateMachine", preload("sm/state_machine.gd"), preload("res://icon.svg"))
	add_autoload_singleton("GlobalEventSystem", "res://addons/ftr_tools/global_event_system/global_event_system.gd")
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("State")
	remove_custom_type("StateMachine")
	remove_autoload_singleton("GlobalEventSystem")
	pass
