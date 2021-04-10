extends Entity

signal knockback(msg)


func _ready() -> void:
	_invulnerability_time = 0.2


func _knockback(msg: Dictionary) -> void:
	emit_signal("knockback", msg)
