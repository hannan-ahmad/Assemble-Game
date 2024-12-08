@tool
extends CharacterBody3D
class_name Player

@export var _speed: float = 3.0:
	set(new_speed):
		_speed = new_speed
		update_configuration_warnings()

@export var _acceleration: float = 6.0:
	set(new_acceleration):
		_acceleration = new_acceleration
		update_configuration_warnings()

@export var _deceleration: float = 4.5:
	set(new_deceleration):
		_deceleration = new_deceleration
		update_configuration_warnings()

@export var _rotation_speed: float = 5.0


func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		return


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


func _get_configuration_warnings() -> PackedStringArray:
	if _speed <= 0.0:
		return ["Speed must be above 0.0."]
	elif _acceleration <= 0.0:
		return ["Acceleration must be above 0.0."]
	elif _deceleration <= 0.0:
		return ["Deceleration must be above 0.0."]
	return []
