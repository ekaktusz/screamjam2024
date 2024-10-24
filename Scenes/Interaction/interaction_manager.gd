extends Node2D

@onready var label: Label = $CanvasLayer/Label
var player = null
const base_text = "[E] to "
var active_areas = []
var can_interact = true

func set_player(playerNode) -> void:
	self.player = playerNode

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		
		# Get the canvas transform and convert world position to screen position
		var canvas_transform = get_viewport().get_canvas_transform()
		var screen_pos = canvas_transform * active_areas[0].global_position
		
		#Apply offset
		screen_pos.y -= 32
		screen_pos.x -= 100
		
		label.position = screen_pos
		label.show()
	else: 
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			await active_areas[0].interact.call()
			can_interact = true
