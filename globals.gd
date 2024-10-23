extends Node


var inventory: Array[String] = ["Leg", "Head", "Torso", "Hands"]

var current_objective: String = ""
var player_movement_blocked: bool = false

var hud_visible = false

func reset_globals() -> void:
	var inventory: Array[String]

	var current_objective: String = ""
	var player_movement_blocked: bool = false

	var hud_visible = false
