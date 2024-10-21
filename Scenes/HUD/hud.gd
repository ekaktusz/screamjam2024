extends Node2D

@onready var objective_text: Label = $CanvasLayer/CurrentObjective/ObjectiveText
@onready var inventory: Control = $CanvasLayer/Inventory

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Globals != null):
		objective_text.text = Globals.current_objective

func _input(event):
	if event.is_action_pressed("open_inventory"):
		inventory.visible = !inventory.visible
		
func add_item_to_inventory(interacted_name) -> void:
	inventory.collect_item(interacted_name)
