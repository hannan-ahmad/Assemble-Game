extends Counter

@onready var item_spawn_point: Marker3D = $ItemSpawnPoint

var current_item: Node3D
var item_name: String


func _ready() -> void:
	set_counter(CounterTypes.SIMPLE)


func give_item() -> void:
	if current_item != null:
		player.current_item[item_name] += 1

		player.update_inventory_ui(player.indexes_dict[item_name])

		current_item.queue_free()

		item_name = ""
