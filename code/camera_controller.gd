extends Node3D

@export var _kitchen_camera_position: Vector3 = Vector3(0.0, 1.0, 0.0)
@export var _kitchen_camera_rotation: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var _front_desk_camera_position: Vector3 = Vector3(0.0, 1.0, 0.0)
@export var _front_desk_camera_rotation: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var _camera_tween_speed: float = 1.25

@onready var _camera: Camera3D = get_child(0)


var _in_kitchen: bool = false

func _kitchen_switch() -> void:
	if _in_kitchen:
		var tween := create_tween()

		tween.tween_property(_camera, "global_position", _kitchen_camera_position, _camera_tween_speed)
		tween.parallel().tween_property(_camera, "global_rotation", _kitchen_camera_rotation, _camera_tween_speed)
	else:
		var tween := create_tween()

		tween.tween_property(_camera, "global_position", _front_desk_camera_position, _camera_tween_speed)
		tween.parallel().tween_property(_camera, "global_rotation", _front_desk_camera_rotation, _camera_tween_speed)


func _on_area_3d_switch_area() -> void:
	#called when the player switches between kitchen and front desk
	_in_kitchen = !_in_kitchen
	_kitchen_switch()
