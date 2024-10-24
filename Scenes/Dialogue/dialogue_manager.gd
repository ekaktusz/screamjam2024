class_name DialogueManager
extends Node

const DialogueBoxScene = preload("res://Scenes/Dialogue/dialogue_box.tscn")
const DialogueChoiceScene = preload("res://Scenes/Dialogue/dialogue_choice.tscn")

var dialogue_box
var dialogue_box_position: Vector2

var dialouge_choice_box
var paragon_choice: String = ""
var renegade_choice: String = ""

var dialogue_lines: Array[String] = []
var current_line_index: int = 0

var is_dialogue_active: bool = false
var current_line_finished: bool = false

# how much is required to wait until a line finished (to make sure player read it)
@export var dialogue_end_wait_time_seconds: float = 0.5
var is_dialogue_end_wait_timer_finished = false

signal dialogue_ended()
signal dialogue_ended_with_paragon()
signal dialogue_ended_with_renegade()

static func create(position: Vector2, lines: Array[String], paragon: String = "", renegade: String = "") -> DialogueManager:
	var instance = DialogueManager.new()
	instance.dialogue_box_position = position
	instance.reset_dialogue(lines, paragon, renegade)
	return instance

func reset_dialogue(lines: Array[String], paragon: String = "", renegade: String = "") -> void:
	self.dialogue_lines = lines
	self.paragon_choice = paragon
	self.renegade_choice = renegade
	self.current_line_index = 0
	self.is_dialogue_active = false
	self.current_line_finished = false
	self.is_dialogue_end_wait_timer_finished = false
	
func _has_choice() -> bool:
	return paragon_choice != "" and renegade_choice != ""

func start_dialogue() -> void:
	if is_dialogue_active:
		return
	is_dialogue_active = true
	Globals.player_movement_blocked = true
	_show_next_dialogue_box()
	
func _show_next_dialogue_box() -> void:
	if dialogue_box != null:
		dialogue_box.queue_free()
	dialogue_box = DialogueBoxScene.instantiate()
	dialogue_box.finished_displaying.connect(_on_dialogue_finished_displaying)
	dialogue_box.set_target_position(dialogue_box_position)  # Use set_target_position instead
	get_tree().root.add_child(dialogue_box)
	dialogue_box.display_text(dialogue_lines[current_line_index])
	current_line_finished = false
	is_dialogue_end_wait_timer_finished = false

	
func _show_dialogue_choice() -> void:
	dialouge_choice_box = DialogueChoiceScene.instantiate()
	dialouge_choice_box.paragon_choice_made.connect(_on_paragon_choice_made)
	dialouge_choice_box.renegade_choice_made.connect(_on_renegade_choice_made)
	#dialouge_choice_box.global_position = dialogue_box.global_position + Vector2(0, 100)
	get_tree().root.add_child(dialouge_choice_box)
	dialouge_choice_box.set_paragon_choice(paragon_choice)
	dialouge_choice_box.set_renegade_choice(renegade_choice)
	
func _on_paragon_choice_made() -> void:
	_end_dialogue()
	dialogue_ended_with_paragon.emit()
	
	
func _on_renegade_choice_made() -> void:
	_end_dialogue()
	dialogue_ended_with_renegade.emit()

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
	if current_line_index == dialogue_lines.size() - 1 and _has_choice():
		_show_dialogue_choice()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_dialogue_active and current_line_finished and is_dialogue_end_wait_timer_finished:
		if _has_choice() and current_line_index >= dialogue_lines.size() - 1:
			return
		
		current_line_index += 1
		
		if current_line_index >= dialogue_lines.size():
			_end_dialogue()
		else:
			_show_next_dialogue_box()

func _end_dialogue():
	is_dialogue_active = false
	current_line_index = 0
	dialogue_box.queue_free()
	if _has_choice():
		dialouge_choice_box.queue_free()
	Globals.player_movement_blocked = false
	dialogue_ended.emit()
	

	
