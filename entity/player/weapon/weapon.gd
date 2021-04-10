extends Node2D

signal attack_finished

onready var next_attack_timer = $next_attack_timer
onready var animator: AnimationPlayer = $animation_player
onready var weapon_stats: WeaponStats = $weapon_stats

var attack_queue := ["attack_1", "attack_2", "attack_3"]
var attack_index = 0
onready var attack_time = weapon_stats.base_speed
onready var attack_wait_time = weapon_stats.base_wait_time

#func _ready() -> void:
##	var _err = owner.connect("attack", self, "_on_attack")
	
func on_attack():
	next_attack_timer.stop()
	
	animator.playback_speed = animator.get_animation("attack_1").length/attack_time
	animator.play(attack_queue[attack_index])
	
	attack_index += 1
	if attack_index > 2:
		attack_index = 0
		
	yield(animator, "animation_finished")
	emit_signal("attack_finished")
	next_attack_timer.start(attack_wait_time)

func _calculate_damage():
	return weapon_stats.base_damage

func _on_next_attack_timer_timeout() -> void:
	attack_index = 0


func _on_weapon_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.on_hit({"damage": _calculate_damage(), "knockback": {"position": owner.position, "force": weapon_stats.knockback}})
		

