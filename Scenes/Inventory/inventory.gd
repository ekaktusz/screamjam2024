extends Control

@onready var torso: TextureRect = $PanelContainer/GridContainer/Torso
@onready var head: TextureRect = $PanelContainer/GridContainer/Head
@onready var right_arm: TextureRect = $PanelContainer/GridContainer/RightArm
@onready var left_arm: TextureRect = $PanelContainer/GridContainer/LeftArm
@onready var leg: TextureRect = $PanelContainer/GridContainer/Leg
@onready var lantern: TextureRect = $PanelContainer/GridContainer/Lantern

func _process(delta) -> void:
	for item_name in Globals.inventory:
		if item_name == "Torso":
			torso.self_modulate = Color.WHITE
		elif item_name == "Head":
			head.self_modulate = Color.WHITE
		elif item_name == "RightArm":
			right_arm.self_modulate = Color.WHITE
		elif item_name == "LeftArm":
			left_arm.self_modulate = Color.WHITE
		elif item_name == "Leg":
			leg.self_modulate = Color.WHITE
		elif item_name == "Lantern":
			lantern.self_modulate = Color.WHITE
