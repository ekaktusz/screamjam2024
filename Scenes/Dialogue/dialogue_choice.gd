extends CanvasLayer

@onready var paragon: Button = $HBoxContainer/Paragon
@onready var renegade: Button = $HBoxContainer/Renegade
@onready var initial_timer: Timer = Timer.new()

signal paragon_choice_made()
signal renegade_choice_made()

var can_use_interact := false  # Flag to control interact input

func _ready() -> void:
	paragon.grab_focus()
	set_process_unhandled_input(false)
	set_process_input(true)
	
	# Setup initial timer
	add_child(initial_timer)
	initial_timer.one_shot = true
	initial_timer.timeout.connect(_on_initial_timer_timeout)
	initial_timer.start(2.0)  # 2 second initial delay

func _input(event: InputEvent) -> void:
	# Stop the event from propagating to other nodes
	if event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		get_viewport().set_input_as_handled()
		if paragon.has_focus():
			renegade.grab_focus()
		else:
			paragon.grab_focus()
	
	elif event.is_action_pressed("interact"):
		# Only handle interact if the timer has finished
		if can_use_interact:
			get_viewport().set_input_as_handled()
			if paragon.has_focus():
				_on_paragon_pressed()
			elif renegade.has_focus():
				_on_renegade_pressed()

func set_paragon_choice(paragon_choice_text: String) -> void:
	paragon.text = paragon_choice_text
	
func set_renegade_choice(renegade_choice_text: String) -> void:
	renegade.text = renegade_choice_text

func _on_paragon_pressed() -> void:
	paragon_choice_made.emit()

func _on_renegade_pressed() -> void:
	renegade_choice_made.emit()

func _on_initial_timer_timeout() -> void:
	can_use_interact = true
