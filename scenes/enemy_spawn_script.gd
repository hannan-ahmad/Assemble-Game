extends Node3D

@export var _enemies: Array[PackedScene] = []

@onready var _enemy_spawn_timer: Timer = %enemy_spaw_timer
@onready var spawn_positions: Array[Node] = []

func _ready() -> void:
	_enemy_spawn_timer.start()
	spawn_positions = get_children()

func _on_enemy_spaw_timer_timeout() -> void:
	var enemy_scene: PackedScene = _enemies.pick_random()
	var enemy_instance: Node3D = enemy_scene.instantiate()
	if spawn_positions.size() == 0:
		return
	else:
		enemy_instance.global_position = spawn_positions.pick_random().global_position
	add_child(enemy_instance)
