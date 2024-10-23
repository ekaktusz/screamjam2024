extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea

signal show_bloody_hand
signal show_hand

const DIALOGUE_LINES:  Array[String] = [
	"Aasdasdad asd dfghdg erte ! g dfgd +",
	" asdasd gggdgffd d",
	" asdas ..... "
]

var dialogue_manager: DialogueManager

func _ready() -> void:
		interaction_area.interact = Callable(self,"_on_interact")
		dialogue_manager = DialogueManager.create(global_position, DialogueDb.priest_starter_dialogue, DialogueDb.priest_paragon_choice_text, DialogueDb.priest_renegade_choice_text )
		add_child(dialogue_manager)
		dialogue_manager.dialogue_ended_with_paragon.connect(_on_grave_digger_dialogue_ended_with_paragon)
		dialogue_manager.dialogue_ended_with_renegade.connect(_on_grave_digger_dialogue_ended_with_renegade)

func _on_interact():
	dialogue_manager.start_dialogue()
	
func _on_grave_digger_dialogue_ended_with_paragon():
	dialogue_manager.reset_dialogue(DialogueDb.priest_paragon_dialogue)
	dialogue_manager.start_dialogue()
	show_bloody_hand.emit()
	Globals.current_objective = "Look around! God may hand it to you"

func _on_grave_digger_dialogue_ended_with_renegade():
	##kill pap
	show_hand.emit()

func _process(_delta: float) -> void:
	pass
