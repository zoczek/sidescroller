extends Camera2D


onready var _player = get_tree().get_nodes_in_group("player")[0]

#func _ready() -> void:
#	GameManager.saved.append(self)

func _physics_process(_delta: float) -> void:
	position = _player.position
