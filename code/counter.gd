extends StaticBody3D
class_name Counter

@onready var player: Player = get_tree().root.get_node("Game/Player3D")

enum CounterTypes {SIMPLE, CRATE, STOVE}

var counter_type: CounterTypes


func set_counter(new_type: CounterTypes) -> void:
	counter_type = new_type
