extends CanvasLayer

@onready var paragon: Button = $HBoxContainer/Paragon
@onready var renegade: Button = $HBoxContainer/Renegade

signal paragon_choice_made()
signal renegade_choice_made()

func set_paragon_choice(paragon_choice_text: String) -> void:
	paragon.text = paragon_choice_text
	
func set_renegade_choice(renegade_choice_text: String) -> void:
	renegade.text = renegade_choice_text

func _on_paragon_pressed() -> void:
	paragon_choice_made.emit()

func _on_renegade_pressed() -> void:
	renegade_choice_made.emit()
