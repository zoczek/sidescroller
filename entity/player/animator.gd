extends AnimationPlayer

class_name Animator

var rotation_locked = false

func _ready() -> void:
	play("player_idle")

func change_direction(direction: int) -> void:
	if not rotation_locked and direction:
		owner.scale.x = owner.scale.y * direction # Hack for rotation: https://github.com/godotengine/godot/issues/12335#issuecomment-570780463
