extends State

signal landing

var charged := false

func enter(msg := {}) -> void:
	if "charged_flag" in msg:
		charged = msg.charged_flag

func exit() -> void:
	if charged:
		emit_signal("landing")
	charged = false
	_parent.velocity.x = 0
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if owner.is_on_floor():
		_state_machine.change_to("move/idle")
		

	
