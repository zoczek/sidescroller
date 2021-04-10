extends Node2D

onready var weapon_stats: WeaponStats = $weapon_stats
onready var projectile_scene := preload("res://entity/player/weapon/projectile.tscn")

signal attack_finished

onready var cooldown := weapon_stats.base_wait_time

func on_attack() -> void:
	var projectile = projectile_scene.instance()
	projectile.position = get_global_transform().origin
	$"../..".add_child(projectile)
	projectile.prepare((get_global_mouse_position() - get_global_transform().origin).normalized())
	projectile.knockback = weapon_stats.knockback
	yield(get_tree().create_timer(cooldown), "timeout")
	emit_signal("attack_finished")
