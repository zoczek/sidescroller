extends State

func process(_delta: float) -> void:
	owner.detect_player()
	if owner.player_detected:
		_state_machine.change_to("move/player_in_sight")


func physics_process(delta):
	_parent.physics_process(delta)
