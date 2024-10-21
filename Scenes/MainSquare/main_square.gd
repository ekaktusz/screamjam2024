extends Node2D

signal arm_collected_on_main_square

func _on_arm_item_collected(item) -> void:
	arm_collected_on_main_square.emit(item)
