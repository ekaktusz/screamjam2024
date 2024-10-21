extends Control

@onready var torso: TextureRect = $PanelContainer/GridContainer/Torso
@onready var head: TextureRect = $PanelContainer/GridContainer/Head
@onready var right_arm: TextureRect = $PanelContainer/GridContainer/RightArm
@onready var left_arm: TextureRect = $PanelContainer/GridContainer/LeftArm
@onready var leg: TextureRect = $PanelContainer/GridContainer/Leg
@onready var lantern: TextureRect = $PanelContainer/GridContainer/Lantern

func _process(delta) -> void:
	var item_options = {
		"Torso": torso,
		"Head": head,
		"RightArm": right_arm,
		"LeftArm": left_arm,
		"Leg": leg,
		"Lantern": lantern
	}
	
	for part_name in item_options:
		if part_name in Globals.inventory:
			item_options[part_name].self_modulate = Color.WHITE
		else:
			item_options[part_name].self_modulate = Color.BLACK
