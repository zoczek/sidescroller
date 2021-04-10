extends Node2D

signal activated
signal completed(msg)
signal progress(msg)


export var max_radius := 300.0
export var min_radius := 100.0

export var loading_time := 10.0


var _is_active := false
var _is_completed := false
var _is_player_in_range := false
var _current_loading_time := 0.0


func _ready() -> void:
	_current_loading_time = loading_time


func _process(delta: float) -> void:
	if _is_active and _is_player_in_range:
		_current_loading_time -= delta
		if _current_loading_time <= 0:
			_complete()
		else:
			emit_signal("progress", _current_loading_time/loading_time)


func on_use():
	if not (_is_completed or _is_active):
		_activate()


func _activate():
	_is_active = true
	emit_signal("activated")
	
	
func _complete() -> void:
	_is_completed = true
	_is_active = false
	emit_signal("completed", self)
	

func _on_crystal_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		_is_player_in_range = false

func _on_crystal_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_is_player_in_range = true
