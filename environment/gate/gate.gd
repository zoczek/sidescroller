extends Node2D

signal activated

var is_active := false

func _ready() -> void:
	get_tree().get_nodes_in_group("map")[0].connect("map_completed", self, "_on_map_completed")


func on_use() -> void:
	if is_active:
		emit_signal("activated")

func _on_map_completed():
	is_active = true
	$view.modulate = Color.darkgreen
	
