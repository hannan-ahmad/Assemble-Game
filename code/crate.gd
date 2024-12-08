@tool
extends Counter

@export var _item_scene: PackedScene


func _ready() -> void:
	set_counter(CounterTypes.CRATE)


func give_item() -> void:
	var new_item: Node3D = _item_scene.instantiate()

	player.item_spawn_point.add_child(new_item)

	if "tomato" in player.current_item.keys():
		player.current_item["tomato"] = player.current_item["tomato"] + 1

		player.update_inventory_ui(player.dict_index)
	else:
		player.current_item["tomato"] = 1
		player.dict_index += 1
		player.indexes_dict["tomato"] = player.dict_index

		player.update_inventory_ui(player.dict_index)
