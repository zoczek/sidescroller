extends Timer


export var spawn_radius := 18
export var enemy_count := 4

export (Array, PackedScene) var enemy_list: Array = []


onready var _tilemap: TileMap = get_tree().get_nodes_in_group("tilemap")[0]


func _ready() -> void:
# warning-ignore:return_value_discarded
	get_parent().connect("activated", self, "_on_activated")
# warning-ignore:return_value_discarded
	get_parent().connect("completed", self, "_on_completed")
	print(enemy_list)
	
	
func _spawn_enemies() -> void:
	var origin_position := _tilemap.world_to_map(get_parent().position)
	var spawn_positions := _get_spawn_positions(origin_position, 5, spawn_radius)
	
	for _i in range((randi() % enemy_count) + 1):
		var pos_index = randi() % spawn_positions.size()
		_spawn_enemy(spawn_positions[pos_index], enemy_list[randi() % enemy_list.size()])
		spawn_positions.remove(pos_index)


func _get_spawn_positions(pos: Vector2, r_min: int, r_max: int) -> Array:
	var spawn_positions := []
	for x in range(pos.x - r_max, pos.x + r_max):
		if abs(x - pos.x) < r_min:
			continue
		for y in range(pos.y - r_max, pos.y + r_max):
			if _tilemap.get_cell(x, y) != -1:
				if _tilemap.get_cell(x, y - 1) == -1 and _tilemap.get_cell(x, y - 2) == -1:
					spawn_positions.append(_tilemap.map_to_world(Vector2(x, y - 1)))
	return spawn_positions


func _spawn_enemy(pos: Vector2, enemy: PackedScene) -> void:
		var enemy_instance = enemy.instance()
		enemy_instance.position = pos
		get_tree().get_current_scene().add_child(enemy_instance)


func _on_activated() -> void:
	_spawn_enemies()
	start()

func _on_completed(_msg: Node2D) -> void:
	stop()

func _on_spawner_timeout() -> void:
	_spawn_enemies()
