extends Node2D

signal boss_spawned(boss)
signal completed

var boss = preload("boss/boss.tscn")

func _ready() -> void:
	yield(GameManager, "scene_ready")
	_place_player()
	
	var boss_inst = boss.instance()
	add_child(boss_inst)
	boss_inst.position = $boss_spawn_position.position
	boss_inst.connect("death", self, "_on_boss_death")
	
	emit_signal("boss_spawned", boss_inst)
	
func _place_player() -> void:
#	var player
#	var players = 
#	if (players.empty()):
#		player = load("entity/player/player.tscn").instance()
#		add_child(player)
#	else:
#		player = players[0]
	get_tree().get_nodes_in_group("player")[0].position = $player_spawn_position.position

func _on_boss_death() -> void:
	emit_signal("completed")
