extends Node2D

signal map_completed

var enemy := preload("res://entity/enemy/enemy.tscn")

onready var player: Node2D = get_tree().get_nodes_in_group("player")[0]
onready var tilemap: TileMap = get_tree().get_nodes_in_group("tilemap")[0]
onready var gate: Node2D = get_tree().get_nodes_in_group("gate")[0]

var spawn_radius := 30
var min_distance := 5

var _crystal_count := 0

func _ready() -> void:
	for crystal in get_tree().get_nodes_in_group("crystal"):
		crystal.connect("completed", self, "_on_crystal_completed")
		_crystal_count += 1
# warning-ignore:return_value_discarded
	gate.connect("activated", self, "_on_gate_activated")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_r"):
		pass
#		_spawn_enemy(get_viewport().get_mouse_position())
#		_spawn_event()

# Spawn enemies around the player with min x distance and max distance
func _spawn_event(count := 3) -> void:
	var origin_position := tilemap.world_to_map(player.position)
	var spawn_positions := []
	for x in range(origin_position.x - spawn_radius, origin_position.x + spawn_radius):
		if abs(x - origin_position.x) < 5:
			continue
		for y in range(origin_position.y - spawn_radius, origin_position.y + spawn_radius):
			if tilemap.get_cell(x, y) != -1:
				if tilemap.get_cell(x, y - 1) == -1 and tilemap.get_cell(x, y - 2) == -1:
					spawn_positions.append(tilemap.map_to_world(Vector2(x, y - 1)))
	
	for _i in range(count):
		var pos_index = randi() % spawn_positions.size()
		_spawn_enemy(spawn_positions[pos_index])
		spawn_positions.remove(pos_index)
	
		
func _spawn_enemy(pos: Vector2) -> void:
		var enemy_instance = enemy.instance()
		enemy_instance.position = pos
		add_child(enemy_instance)
	

func _on_crystal_completed(_msg: Node2D) -> void:
	_crystal_count -= 1
	if _crystal_count == 0:
		emit_signal("map_completed")

func _on_gate_activated() -> void:
	GameManager.change_scene("res://environment/boss_arena/boss_arena.tscn")

func _on_spawn_timer_timeout() -> void:
	_spawn_event(randi() % 3)

