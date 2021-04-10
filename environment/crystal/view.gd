extends Node2D

export var max_circle_size := 18.0
export var min_circle_size := 5.0


onready var sprites := [$bottom, $top]
onready var circle: Sprite = $circle

func _ready() -> void:
# warning-ignore:return_value_discarded
	owner.connect("activated", self, "_on_activated")
# warning-ignore:return_value_discarded
	owner.connect("completed", self, "_on_completed")
# warning-ignore:return_value_discarded
	owner.connect("progress", self, "_on_progress")
	max_circle_size = owner.max_radius / 16 # 16 is base sprite radius

func _set_circle_size(size: float) -> void:
	circle.scale.x = size
	circle.scale.y = size


func _on_activated() -> void:
	circle.visible = true

func _on_completed(_msg: Node2D) -> void:
	for sprite in sprites:
		sprite.modulate = Color.darkgreen
	circle.visible = false
	
func _on_progress(progress: float) -> void:
	_set_circle_size(progress * (max_circle_size - min_circle_size) + min_circle_size)
