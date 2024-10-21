extends Control

@onready var torso: TextureRect = $PanelContainer/GridContainer/Torso
@onready var head: TextureRect = $PanelContainer/GridContainer/Head
@onready var right_arm: TextureRect = $PanelContainer/GridContainer/RightArm
@onready var left_arm: TextureRect = $PanelContainer/GridContainer/LeftArm
@onready var leg: TextureRect = $PanelContainer/GridContainer/Leg
@onready var lantern: TextureRect = $PanelContainer/GridContainer/Lantern


var inventory: Array[Bodypart] = [
	Bodypart.new("Head", false),
	Bodypart.new("Torso", false),
	Bodypart.new("RightArm", false),
	Bodypart.new("LeftArm", false),
	Bodypart.new("Leg", false),
]

func collect_item(item_name: String):
	for part in inventory:
		if part.get_bodypart() == item_name:
			part.is_collected = true
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
