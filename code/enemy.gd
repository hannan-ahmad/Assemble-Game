extends CharacterBody3D
@export var enemy_stats: EnemyStats

var _speed: float = 0.0

func _physics_process(delta: float) -> void:
    if enemy_stats != null:
        _speed = enemy_stats.speed
    else:
        pass

    global_position -= _speed * delta * global_transform.basis.x

    move_and_slide()
