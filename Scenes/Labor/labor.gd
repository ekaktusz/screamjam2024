extends Node2D

signal torso_collected_in_labor

func _on_item_collected(item) -> void:
	torso_collected_in_labor.emit(item)
