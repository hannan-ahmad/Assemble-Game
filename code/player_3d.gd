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

@onready var _ray_cast: RayCast3D = $RayCast
@onready var _inventory_ui: GridContainer = %InventoryUI

var _in_kitchen: bool = false
var _current_counter: Counter
var current_item: Dictionary = {}
var indexes_dict: Dictionary = {}
var dict_index: int = -1
var counter_function: Dictionary = {}
var test_list: Array[String]


func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		return

	for i: Button in _inventory_ui.get_children():
		if not i.is_connected("pressed", _on_inventory_button_pressed):
			i.pressed.connect(_on_inventory_button_pressed.bind(i))


func _on_inventory_button_pressed(button: Button) -> void:
	if _current_counter != null and _current_counter.counter_type == Counter.CounterTypes.SIMPLE:
		if button.text != "":
			for i: String in indexes_dict.keys():
				if indexes_dict[i] == button.get_index():
					counter_function[i].place_item_on_simple_counter(_current_counter)

					update_inventory_ui(indexes_dict[i])


func update_inventory_ui(index: int) -> void:
	var slot: Button = _inventory_ui.get_child(index)

	for i: String in indexes_dict.keys():
		if indexes_dict[i] == index:
			slot.text = i + ": " + str(current_item[i])


func _physics_process(delta: float) -> void:
	_handle_input(delta)
	_check_for_counter()

	if Input.is_action_just_pressed("interact") and _current_counter != null:		# e key
		_interact_with_counter()

	move_and_slide()


func _interact_with_counter() -> void:
	match _current_counter.counter_type:
		Counter.CounterTypes.CRATE:
			_current_counter.give_item()


func _get_configuration_warnings() -> PackedStringArray:
	if _speed <= 0.0:
		return ["Speed must be above 0.0."]
	elif _acceleration <= 0.0:
		return ["Acceleration must be above 0.0."]
	elif _deceleration <= 0.0:
		return ["Deceleration must be above 0.0."]
	return []


func _on_area_3d_switch_area() -> void:
	#called when the player switches between kitchen and front desk
	_in_kitchen = !_in_kitchen
	match _in_kitchen:
		true:
			global_position.x -= 3.0
		false:
			global_position.x += 3.0


func _handle_input(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)

	if input_vector.length() > 0.0:
		var target_velocity := direction * _speed

		velocity = velocity.move_toward(target_velocity, _acceleration * delta)

		var target_rotation_y := Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)

		rotation.y = lerp_angle(rotation.y, target_rotation_y, _rotation_speed * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, _deceleration * delta)

	match _in_kitchen: #PUT DIFFERENCES HERE TRUE MEANS THAT YOU ARE IN THE KITCHEN
		true:
			axis_lock_angular_y = false
		false:
			axis_lock_angular_y = true
			global_rotation_degrees = Vector3(0.0, -90, 0.0)


func _check_for_counter() -> void:
	if _ray_cast.is_colliding() and _current_counter == null:
		if _ray_cast.get_collider() is Counter:
			_current_counter = _ray_cast.get_collider()

	elif not _ray_cast.is_colliding() or _ray_cast.get_collider() != _current_counter:
		_current_counter = null
