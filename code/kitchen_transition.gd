extends Area3D

signal switch_area


func _on_body_entered(body:Node3D) -> void:
	if body.is_in_group("player"):
		print("Player entered the area")
		switch_area.emit()