extends CollisionShape2D

onready var _max_detector_size: float = owner.max_radius
onready var _min_detector_size: float = owner.min_radius

func _ready() -> void:
# warning-ignore:return_value_discarded
	owner.connect("activated", self, "_on_activated")
# warning-ignore:return_value_discarded
	owner.connect("progress", self, "_on_progress")


func _on_activated() -> void:
	shape.radius = _max_detector_size
	

func _on_progress(progress: float) -> void:
	shape.radius = progress * (_max_detector_size - _min_detector_size) + _min_detector_size

