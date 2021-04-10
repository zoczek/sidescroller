extends Area2D

var _usable_list := []

func use():
	if not _usable_list.empty():
		_find_nearest().on_use()

func _find_nearest() -> Node2D:
	var min_distance = (owner.position - _usable_list[0].position).length()
	var min_distance_object = _usable_list[0]
	for usable in _usable_list:
		var distance = (usable.position - owner.position).length()
		if distance < min_distance:
			min_distance = distance
			min_distance_object = usable
				
	return min_distance_object

func _on_usable_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("usable"):
		_usable_list.append(area)

func _on_usable_range_area_exited(area: Area2D) -> void:
	if area == null or (area.is_in_group("usable") and area in _usable_list):
		_usable_list.erase(area)
