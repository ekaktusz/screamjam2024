class_name DialogueManager
extends Node

const DialogueBoxScene = preload("res://Scenes/Dialogue/dialogue_box.tscn")

var dialogue_box
var dialogue_box_position: Vector2

var dialogue_lines: Array[String] = []
var paragon_choice: String = ""
var renegade_choice: String = ""
var current_line_index: int = 0

var is_dialogue_active: bool = false
var current_line_finished: bool = false

# how much is required to wait until a line finished (to make sure player read it)
@export var dialogue_end_wait_time_seconds: float = 0.5
var is_dialogue_end_wait_timer_finished = false

signal dialogue_ended()

static func create(position: Vector2, lines: Array[String], paragon: String = "", renegade: String = "") -> DialogueManager:
	var instance = DialogueManager.new()
	instance.dialogue_box_position = position
	instance.dialogue_lines = lines
	instance.paragon_choice = paragon
	instance.renegade_choice = renegade
	return instance
	
func _has_choice() -> bool:
	return paragon_choice != "" and renegade_choice != ""

func start_dialogue() -> void:
	if is_dialogue_active:
		return
	_show_next_dialogue_box()
	is_dialogue_active = true
	
func _show_next_dialogue_box() -> void:
	dialogue_box = DialogueBoxScene.instantiate()
	dialogue_box.finished_displaying.connect(_on_dialogue_finished_displaying)
	get_tree().root.add_child(dialogue_box)
	dialogue_box.global_position = dialogue_box_position
	dialogue_box.display_text(dialogue_lines[current_line_index])
	current_line_finished = false
	is_dialogue_end_wait_timer_finished = false
	
func _on_dialogue_finished_displaying() -> void:
	current_line_finished = true
	_start_dialogue_end_wait_timer()
	
func _start_dialogue_end_wait_timer() -> void:
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(dialogue_end_wait_time_seconds)
	timer.timeout.connect(_on_dialogue_end_wait_timer_finished)
	add_child(timer)
	timer.start()

func _on_dialogue_end_wait_timer_finished() -> void:
	is_dialogue_end_wait_timer_finished = true
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_dialogue_active and current_line_finished and is_dialogue_end_wait_timer_finished:
		dialogue_box.queue_free()
		current_line_index += 1
		
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			dialogue_ended.emit()
			return
			
		_show_next_dialogue_box()	
