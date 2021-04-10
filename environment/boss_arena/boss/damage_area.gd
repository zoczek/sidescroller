extends Area2D

onready var landing_collision: CollisionShape2D = $landing_collision
onready var landing_sprite: Sprite = $landing_sprite

func _ready() -> void:
# warning-ignore:return_value_discarded
	owner.get_node("state_machine/move/air").connect("landing", self, "_on_landing")
	
func _on_landing():
	landing_collision.disabled = false
	landing_sprite.visible = true
	yield(get_tree().create_timer(0.5), "timeout")
	landing_collision.disabled = true
	landing_sprite.visible = false
