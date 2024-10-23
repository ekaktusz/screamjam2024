extends CanvasLayer

@onready var paragon: Button = $HBoxContainer/Paragon
@onready var renegade: Button = $HBoxContainer/Renegade

signal paragon_choice_made()
signal renegade_choice_made()

func _ready() -> void:
	paragon.grab_focus()
	set_process_unhandled_input(false)  # Disable unhandled input
	set_process_input(true)

func _input(event: InputEvent) -> void:
	# Stop the event from propagating to other nodes
	if event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		get_viewport().set_input_as_handled()
		if paragon.has_focus():
			renegade.grab_focus()
		else:
			paragon.grab_focus()
	
	elif event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()  # Prevent event from reaching DialogueManager
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
