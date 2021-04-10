extends RichTextLabel


func _ready() -> void:
# warning-ignore:return_value_discarded
	owner.connect("completed", self, "_on_map_completed")
	

func _on_map_completed() -> void:
	visible = true
