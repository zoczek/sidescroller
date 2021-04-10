extends Node2D

var arrow = preload("ui_player_arrow.tscn")

onready var gate: Node2D = get_tree().get_nodes_in_group("gate")[0]

var crystal_to_arrow := {}

func _enter_tree() -> void:
	for child in get_children():
		child.queue_free()
		
	get_tree().get_nodes_in_group("map")[0].connect("map_completed", self, "_on_map_completed")
	
	_spawn_objective_arrows()


func _spawn_objective_arrows() -> void:
	for crystal in get_tree().get_nodes_in_group("crystal"):
		crystal.connect("completed", self, "_on_crystal_completed")
		var arrow_instance = arrow.instance()
		arrow_instance.target = crystal
		add_child(arrow_instance)
		crystal_to_arrow[crystal] = arrow_instance


func _on_crystal_completed(crystal: Node2D):
	crystal_to_arrow[crystal].queue_free()
# warning-ignore:return_value_discarded
	crystal_to_arrow.erase(crystal)
		

func _on_map_completed() -> void:
	var arrow_instance = arrow.instance()
	arrow_instance.target = gate
	add_child(arrow_instance)
