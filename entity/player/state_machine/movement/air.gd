extends State

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func process(delta: float) -> void:
	_parent.process(delta)

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	
	if owner.is_on_floor() and _parent.velocity.y >= 0:
		_state_machine.change_to("move/run")

func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	
	if "velocity" in msg:
		_parent.velocity.y -= msg.velocity

