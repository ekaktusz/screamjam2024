extends Node

class_name Bodypart

var bodypart: String
var is_collected: bool

func _init(part_name: String = "", collected: bool = false):
	bodypart = part_name
	is_collected = collected

func get_bodypart() -> String:
	return bodypart

##todo delete this
func _to_string():
	return "{ValueA: %s, ValueB: %s}" % [bodypart, is_collected]
