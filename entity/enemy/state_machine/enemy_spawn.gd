extends State

onready var animation_player: AnimationPlayer = owner.get_node("sprite").get_node("animation_player")

func enter(_msg := {}):
	animation_player.play("spawn")
	yield(animation_player, "animation_finished")
	_state_machine.change_to("move")
