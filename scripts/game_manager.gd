extends Node2D

signal scene_ready

var persistent := [
	load("entity/player/player.tscn").instance(),
	load("ui/ui.tscn").instance()
]
var saved := persistent # Used to save prefabs between scenes.

func change_scene(scene: String):
	for item in saved:
		get_tree().get_current_scene().remove_child(item)
	
	var current_scene = get_tree().get_current_scene()
	get_tree().get_root().remove_child(current_scene)
	
	var next_scene = load(scene).instance()
	for item in saved:
		next_scene.add_child(item)
		
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
	
	emit_signal("scene_ready")

func restart_game() -> void:
	saved = persistent
	change_scene("res://environment/main_menu.tscn")
	
