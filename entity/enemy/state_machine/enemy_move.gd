extends State

export var movement_speed := Vector2(100.0, 500.0)
export var acceleration := Vector2(1000.0, 3000.0)
export var jump_force := 600.0

var _velocity := Vector2()
var _direction := 1

onready var _player: Entity = get_tree().get_nodes_in_group("player")[0]
onready var _edge_detector: RayCast2D = owner.get_node("edge_detector")
onready var _wall_detector: RayCast2D = owner.get_node("wall_detector")


func _ready() -> void:
# warning-ignore:return_value_discarded
	owner.connect("knockback", self, "_knockback")

func physics_process(delta: float) -> void:
# warning-ignore:narrowing_conversion
	_direction = sign(_player.position.x - owner.position.x)
	_change_direction(_direction)
	
	_velocity.y = move_toward(_velocity.y, movement_speed.y, acceleration.y * delta)
	_velocity.x = move_toward(_velocity.x, _direction * movement_speed.x, acceleration.x * delta) 
	
	if owner.is_on_floor():
		if _detect_wall():
			_jump(jump_force)
		else:
			_jump(jump_force/1.5)
	if not _detect_floor():
		if _velocity.x * _direction > 0:
			_velocity.x = 0
	
	_velocity = owner.move_and_slide(_velocity, Vector2.UP)


func _jump(force: float) -> void:
	_velocity.y -= force


func _knockback(msg = {}):
	_velocity.x += msg.force * sign(owner.position.x - msg.position.x)


func _change_direction(dir: int) -> void:
	owner.scale.x = owner.scale.y * dir


func _detect_wall() -> bool:
	return _wall_detector.get_collider() != null and _wall_detector.get_collider().is_in_group("wall")

	
func _detect_floor() -> bool:
	return _edge_detector.get_collider() != null and _edge_detector.get_collider().is_in_group("wall")
