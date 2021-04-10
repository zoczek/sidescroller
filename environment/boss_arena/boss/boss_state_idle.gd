extends State

onready var animator: AnimationPlayer = owner.get_node("animator")
onready var jump_timer: Timer = $jump_timer


func process(_delta: float) -> void:
	animator.play("idle")

func enter(_msg = {}):
	$jump_timer.start()

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if not owner.is_on_floor():
		_state_machine.change_to("move/air")

func _on_jump_timer_timeout() -> void:
	yield(animator, "animation_finished")
	_state_machine.change_to("move/charge")

	
