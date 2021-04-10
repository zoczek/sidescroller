extends State

var player: Node2D

var movement_speed = Vector2(50.0, 500)
var gravity := 2000.0


var velocity := Vector2()
var target_position := Vector2()
var movement_direction := 0

func _ready() -> void:
	._ready()
	var players = get_tree().get_nodes_in_group("player")
	if not players.empty():
		player = players[0]

func physics_process(delta: float) -> void:
	velocity.y = move_toward(velocity.y, movement_speed.y, delta * gravity)
	if (player.position.x - owner.position.x) * movement_direction <= 0: # If crossed target position
		movement_direction = 0
	velocity.x = movement_direction * movement_speed.x
	velocity = owner.move_and_slide(velocity, Vector2.UP)
