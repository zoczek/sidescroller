extends State

signal dodge(time)

onready var animator: Animator = owner.get_node("animator")
onready var usable_range: Area2D = owner.get_node("usable_range")

export var max_speed_default := Vector2(150.0, 500.0)
export var acceleration_default := Vector2(1000.0, 2000.0)
export var jump_height = 55

var max_speed = max_speed_default
var acceleration := acceleration_default
var jump_velocity := 0.0

var _dodge_velocity := 300.0
var _can_dodge = true
var _dodge_time = 0.5

var velocity := Vector2.ZERO


func _init() -> void:
	jump_velocity = sqrt(2 * acceleration.y * jump_height)

func _ready() -> void:
	._ready()
# warning-ignore:return_value_discarded
	owner.connect("knockback", self, "_knockback")

func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("game_jump"):
		_state_machine.change_to("move/air", {"velocity":jump_velocity})
	elif event.is_action_pressed("game_dodge") and _can_dodge:
		_dodge()
		_can_dodge = false
		$dodge_cooldown.start()
	elif event.is_action_pressed("game_use"):
		_use_object()

func physics_process(delta: float) -> void:
	_calculate_velocity(delta)
	velocity = owner.move_and_slide(velocity, Vector2.UP)


func _use_object():
	usable_range.use()


func _calculate_velocity(delta: float) -> void:
	var dir = _get_direction()
	velocity.x = move_toward(velocity.x, max_speed.x * dir, acceleration.x * delta)
	velocity.y = move_toward(velocity.y, max_speed.y, acceleration.y * delta)


func _knockback(msg := {}) -> void:
	velocity.x += msg.force * sign(owner.position.x - msg.position.x)


func _dodge() -> void:
	velocity.x += _dodge_velocity * _get_direction()
	emit_signal("dodge", _dodge_time)


func _get_direction() -> int:
	var dir = 0
	if Input.is_action_pressed("game_left"):
		dir -= 1
	if Input.is_action_pressed("game_right"):
		dir += 1
	return dir


func _on_dodge_cooldown_timeout() -> void:
	_can_dodge = true
