extends Entity

signal knockback(val)

var health_regen = 2.0
onready var regen_timer = $regen_timer

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect("death", GameManager, "restart_game")

# warning-ignore:return_value_discarded
	$state_machine_movement/move.connect("dodge", self, "_on_dodge")

func _knockback(msg := {}) -> void:
	emit_signal("knockback", msg)

# Handling signals

func _on_dodge(time: float) -> void:
	_start_state_timer("invulnerable", time)


func _on_regen_timer_timeout() -> void:
	self._current_health += health_regen

