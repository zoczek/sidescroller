extends Node2D

class_name State

var _state_machine : Node = null
var _parent : State = null

func _ready() -> void:
	yield(owner, "ready")
	_state_machine = _get_state_machine(self)
	_parent = get_parent() as State

func process(_delta : float) -> void:
	pass

func physics_process(_delta : float) -> void:
	pass

func input(_event : InputEvent) -> void:
	pass

func unhandled_input(_event : InputEvent) -> void:
	pass
	
func enter(_msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
