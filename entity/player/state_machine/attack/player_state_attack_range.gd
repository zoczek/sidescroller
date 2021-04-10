extends State

onready var animator: Animator = owner.get_node("animator")

onready var weapon = owner.get_node("weapon_range")

func enter(_msg: Dictionary = {}) -> void:
	animator.change_direction(int(sign(get_global_mouse_position().x - owner.position.x)))
	animator.rotation_locked = true
	yield(weapon.on_attack(), "completed")
	_state_machine.change_to("idle")
	animator.rotation_locked = false

