extends State


onready var animator = owner.get_node("animator")

var jump_force := 1000.0
var jump_time := 0.0


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	

func jump_on_player() -> void:
	jump_time = (2 * jump_force - 500) / _parent.gravity # Stop above player
	_parent.target_position = _parent.player.position
	_parent.movement_speed.x = abs(owner.position.x - _parent.target_position.x) / jump_time
	_parent.movement_direction = sign(_parent.target_position.x - owner.position.x)
	_parent.velocity.y -= jump_force


func enter(_msg := {}):
	animator.play("charge")
	yield(animator, "animation_finished")
	jump_on_player()
	_state_machine.change_to("move/air", {"charged_flag": true})
