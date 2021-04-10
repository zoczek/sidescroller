extends Sprite

var target: Node2D = null

func _process(_delta: float) -> void:
	if target != null:
		look_at(target.position)
