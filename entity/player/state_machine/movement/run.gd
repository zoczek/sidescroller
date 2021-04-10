extends State

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func process(delta: float) -> void:
	_parent.process(delta)

func physics_process(delta:float) -> void:
	_parent.physics_process(delta)
	
	if not owner.is_on_floor():
		_state_machine.change_to("move/air")
