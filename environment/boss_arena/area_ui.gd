extends CanvasLayer

onready var _boss_hp: TextureProgress = $boss_hp
var _boss: Node2D = null

var _is_active := false

func _ready() -> void:
# warning-ignore:return_value_discarded
	get_parent().connect("boss_spawned", self, "_on_boss_spawn")

func _process(_delta: float) -> void:
	if _is_active:
		_boss_hp.value = _boss.current_health/_boss.max_health


func _on_boss_spawn(boss: Node2D) -> void:
	_is_active = true
	_boss = boss
# warning-ignore:return_value_discarded
	boss.connect("death", self, "_on_boss_death")
	
func _on_boss_death() -> void:
	_is_active = false
	_boss_hp.visible = false
	$boss_name.visible = false
	
