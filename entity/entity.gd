extends KinematicBody2D

class_name Entity

signal death

export var _max_health := 100.0

export var _no_damage := false
export var _no_knockback := false
export var _no_status := false

export var _invulnerability_time = 1.0

export onready var _current_health := _max_health setget _set_health
var _current_state = {}

func _process(delta: float) -> void:
	_move_state_timers(delta)


func on_hit(msg := {}) -> void:
	if "invulnerable" in _current_state:
		return
		
	if "damage" in msg and not _no_damage:
		_take_damage(msg.damage)
	if "knockback" in msg and not _no_knockback:
		_knockback(msg.knockback)


func _take_damage(damage: float) -> void:	
	self._current_health -= damage
	_start_state_timer("invulnerable", _invulnerability_time)


func _knockback(_knockback: Dictionary) -> void:
	pass


func _start_state_timer(state: String, time: float) -> void:
	_current_state[state] = time


func _move_state_timers(delta: float):
	for state in _current_state:
		_current_state[state] -= delta
		if _current_state[state] <= 0:
			_current_state.erase(state)


func _set_health(val: float) -> void:
	_current_health = clamp(val, 0, _max_health)
	if _current_health == 0:
		emit_signal("death")
		queue_free()
