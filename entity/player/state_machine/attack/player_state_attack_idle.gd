extends State

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_attack"):
		_state_machine.change_to("attack/melee")
	if event.is_action_pressed("game_attack_range"):
		_state_machine.change_to("attack/range")
		
	

