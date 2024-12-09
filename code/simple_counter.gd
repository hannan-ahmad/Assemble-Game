extends Counter

@onready var item_spawn_point: Marker3D = $ItemSpawnPoint

var current_item: Node3D


func _ready() -> void:
	set_counter(CounterTypes.SIMPLE)


func _take_item() -> void:
	pass
