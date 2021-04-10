extends KinematicBody2D

var _velocity: Vector2 = Vector2()
export var speed := 30.0 

var knockback := 0.0
var damage := 30.0

func _physics_process(_delta: float) -> void:
	var collision = move_and_collide(_velocity)
	if collision != null:
		if collision.collider.is_in_group("enemy"):
			collision.collider.on_hit({"damage": damage, "knockback": {"position": position, "force": knockback}})
			queue_free()
		elif collision.collider.is_in_group("wall"):
			queue_free()
	if position > Vector2(1e5, 1e5):
		queue_free()

		
func prepare(direction: Vector2):
	_velocity = direction * speed
	rotate(Vector2.LEFT.angle_to(direction))
