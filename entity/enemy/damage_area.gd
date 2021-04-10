extends Area2D

export var damage := 20.0
export var force := 1000.0

func _process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.on_hit({"damage": damage, "knockback": {"position": owner.position, "force": force}})
