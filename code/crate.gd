@tool
extends Counter

@export var _item_scene: PackedScene:
	set(new_scene):
		_item_scene = new_scene

		update_configuration_warnings()

@export var _item_name: String:
	set(new_name):
		_item_name = new_name

		update_configuration_warnings()


func _ready() -> void:
	set_counter(CounterTypes.CRATE)


func give_item() -> void:
	var new_item: Node3D = _item_scene.instantiate()

	if _item_name in player.current_item.keys():
		player.current_item[_item_name] += 1

		player.update_inventory_ui(player.indexes_dict[_item_name])
	else:
		player.current_item[_item_name] = 1
		player.dict_index += 1
		player.indexes_dict[_item_name] = player.dict_index
		player.counter_function[_item_name] = self

		player.update_inventory_ui(player.dict_index)


func _get_configuration_warnings() -> PackedStringArray:
	if _item_name == "":
		return ["Item Name cannot be nothing."]
	elif _item_scene == null:
		return ["This crate must have item scene set."]

	return []


func place_item_on_simple_counter(simple_counter: Counter) -> void:
	if simple_counter.current_item == null and player.current_item[_item_name] > 0:
		var new_item: Node3D = _item_scene.instantiate()

		simple_counter.item_spawn_point.add_child(new_item)

		simple_counter.current_item = new_item

		player.current_item[_item_name] -= 1

		player.update_inventory_ui(player.indexes_dict[_item_name])
