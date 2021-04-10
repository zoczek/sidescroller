extends TextureProgress

onready var player: Node2D = get_tree().get_nodes_in_group("player")[0]

func _process(_delta: float) -> void:
	value = player._current_health/player._max_health
