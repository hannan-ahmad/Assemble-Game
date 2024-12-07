extends CharacterBody3D

@export var _speed: float = 3.0
@export var _acceleration: float = 6.0
@export var _deceleration: float = 4.5
@export var _rotation_speed: float = 5.0


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)

	if input_vector.length() > 0.0:
		var target_velocity := direction * _speed
		velocity = velocity.move_toward(target_velocity, _acceleration * delta)

		var target_rotation_y := Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)

		rotation.y = lerp_angle(rotation.y, target_rotation_y, _rotation_speed * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, _deceleration * delta)

	move_and_slide()
