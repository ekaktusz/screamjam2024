extends Control

@onready var head: TextureRect = $PanelContainer/GridContainer/Head
@onready var head_bloody: TextureRect = $PanelContainer/GridContainer/HeadBloody
@onready var hands: TextureRect = $PanelContainer/GridContainer/Hands
@onready var hands_bloody: TextureRect = $PanelContainer/GridContainer/HandsBloody
@onready var torso: TextureRect = $PanelContainer/GridContainer/Torso
@onready var leg: TextureRect = $PanelContainer/GridContainer/Leg
@onready var leg_bloody: TextureRect = $PanelContainer/GridContainer/LegBloody
@onready var lantern: TextureRect = $PanelContainer/GridContainer/Lantern


func _process(_delta) -> void:
	var item_options = {
		"Head": head,
		"HeadBloody": head_bloody,
		"Hands": hands,
		"HandsBloody": hands_bloody,
		"Torso": torso,
		"Leg": leg,
		"LegBloody": leg_bloody,
		"Lantern": lantern
	}
	
	for part_name in item_options:
		if part_name in Globals.inventory:
			item_options[part_name].visible = true
			item_options[part_name].self_modulate = Color.WHITE
		else:
			item_options[part_name].visible = false
