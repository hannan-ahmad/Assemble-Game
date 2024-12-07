extends CharacterBody3D

@export var _speed: float = 3.0


func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)

	velocity = direction * _speed

	look_at(global_position + direction)

	move_and_slide()
