extends KinematicBody2D

signal damage_taken(position)
signal death


var max_health := 100.0
onready var current_health := max_health

var _is_invulnerable := false
onready var _invulnerability_timer = $invulnerability_timer
var health_regen = 2.0
onready var regen_timer = $regen_timer

func _ready() -> void:
	GameManager.saved.append(self)

func on_hit(msg := {}) -> void:
	if not _is_invulnerable:
		if "damage" in msg:
			current_health -= msg.damage
			if current_health <= 0:
				GameManager.restart_game()
		
		var knockback = {"position": position, "force": 0}
		if "knockback" in msg:
			knockback = msg.knockback
		emit_signal("damage_taken", knockback)
		
		_is_invulnerable = true
		_invulnerability_timer.start()


func _on_regen_timer_timeout() -> void:
	current_health += health_regen
	current_health = clamp(current_health, 0, max_health)


func _on_invulnerability_timer_timeout() -> void:
	_is_invulnerable = false
