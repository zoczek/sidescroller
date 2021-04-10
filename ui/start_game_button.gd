extends Button


func _on_start_game_button_button_up() -> void:
	GameManager.change_scene("res://environment/test_arena.tscn")
