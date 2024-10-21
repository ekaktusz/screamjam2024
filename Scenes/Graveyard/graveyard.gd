extends Node2D

@onready var lantern: Node2D = $Lantern

func _on_lantern_item_collected(item_name) -> void:
	Globals.inventory.append(item_name)
	print(item_name)
	Globals.current_objective = "bring the lantern to the grave digger"
