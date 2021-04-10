extends KinematicBody2D

signal death

var max_health := 1000.0
var current_health := max_health

func on_hit(msg := {}) -> void:
	if "damage" in msg:
		current_health -= msg.damage
		if current_health <= 0:
			emit_signal("death")
			queue_free()
			
func _on_damage_area_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.on_hit({"damage": 50.0, "knockback":{"position": position, "force": 3000.0}})
