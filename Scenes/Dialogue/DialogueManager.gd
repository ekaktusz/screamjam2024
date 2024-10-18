extends Node

const DialogueBoxScene = preload("res://Scenes/Dialogue/dialogue_box.tscn")

var dialogue_box
var dialogue_box_position: Vector2

var dialogue_lines: Array[String] = []
var current_line_index: int = 0

var is_dialogue_active: bool = false
var current_line_finished: bool = false

signal dialogue_ended()

func start_dialogue(position: Vector2, lines: Array[String]) -> void:
	if is_dialogue_active:
		return
		
	dialogue_lines = lines
	dialogue_box_position = position
	_show_next_dialogue_box()
	
	is_dialogue_active = true
	
func _show_next_dialogue_box():
	dialogue_box = DialogueBoxScene.instantiate()
	dialogue_box.finished_displaying.connect(_on_dialogue_finished_displaying)
	get_tree().root.add_child(dialogue_box)
	dialogue_box.global_position = dialogue_box_position
	dialogue_box.display_text(dialogue_lines[current_line_index])
	current_line_finished = false
	
func _on_dialogue_finished_displaying():
	current_line_finished = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_dialogue_active and current_line_finished:
		dialogue_box.queue_free()
		current_line_index += 1
		
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			dialogue_ended.emit()
			return
			
		_show_next_dialogue_box()	
