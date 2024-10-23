extends CanvasLayer

@onready var paragon: Button = $HBoxContainer/Paragon
@onready var renegade: Button = $HBoxContainer/Renegade

signal paragon_choice_made()
signal renegade_choice_made()

func _ready() -> void:
	# Set initial focus to paragon button when the scene loads
	paragon.grab_focus()
	
	# Connect to process input
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		# Toggle focus between buttons
		if paragon.has_focus():
			renegade.grab_focus()
		else:
			paragon.grab_focus()
	
	# Handle selection with interact button
	elif event.is_action_pressed("interact"):
		if paragon.has_focus():
			paragon.pressed.emit()
		elif renegade.has_focus():
			renegade.pressed.emit()

func set_paragon_choice(paragon_choice_text: String) -> void:
	paragon.text = paragon_choice_text
	
func set_renegade_choice(renegade_choice_text: String) -> void:
	renegade.text = renegade_choice_text

# Fixed the function names by removing asterisks and using proper connection naming
func _on_paragon_pressed() -> void:
	paragon_choice_made.emit()

func _on_renegade_pressed() -> void:
	renegade_choice_made.emit()
