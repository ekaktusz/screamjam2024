extends Node


var inventory: Array[String] #= ["Leg", "Head", "Torso", "Hands"]

var current_objective: String = ""
var player_movement_blocked: bool = false

var hud_visible = false

func reset_globals() -> void:
	inventory.clear()
	current_objective = ""
	player_movement_blocked = false
	hud_visible = false
