extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")

func _on_interact():
	print('item picked up')
	Inventory.collect_item("Torso")
	queue_free()
