extends ProgressBar

func _process(_delta: float) -> void:
	value = owner._current_health/owner._max_health
