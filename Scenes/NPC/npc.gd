extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var collision_shape_2d_talk: CollisionShape2D = $InteractionArea/CollisionShape2D
@onready var npc: CharacterBody2D = $"."

signal show_bloody_hand
signal show_hand
signal show_bloody_leg
signal show_leg


var dialogue_manager: DialogueManager

func _ready() -> void:
		interaction_area.interact = Callable(self,"_on_interact")
		print (npc.name)
		if npc.name == "Priest1":
			sprite_2d.play("priest_idle")
			dialogue_manager = DialogueManager.create(global_position, DialogueDb.priest_starter_dialogue, DialogueDb.priest_paragon_choice_text, DialogueDb.priest_renegade_choice_text )
			dialogue_manager.dialogue_ended_with_paragon.connect(_on_priest_dialogue_ended_with_paragon)
			dialogue_manager.dialogue_ended_with_renegade.connect(_on_priest_dialogue_ended_with_renegade)
			add_child(dialogue_manager)
			
		if npc.name == "Pirate":
			sprite_2d.play("pirate_idle")
			dialogue_manager = DialogueManager.create(global_position, DialogueDb.pirate_starter_dialogue, DialogueDb.pirate_paragon_choice_text, DialogueDb.pirate_renegade_choice_text )
			dialogue_manager.dialogue_ended_with_paragon.connect(_on_pirate_dialogue_ended_with_paragon)
			dialogue_manager.dialogue_ended_with_renegade.connect(_on_pirate_dialogue_ended_with_renegade)
			add_child(dialogue_manager)
		

func _on_interact():
	dialogue_manager.start_dialogue()
	
func _on_priest_dialogue_ended_with_paragon():
	dialogue_manager.reset_dialogue(DialogueDb.priest_paragon_dialogue)
	dialogue_manager.start_dialogue()
	collision_shape_2d_talk.disabled = true
	show_hand.emit()
	Globals.current_objective = "Look around! God may hand it to you"

func _on_priest_dialogue_ended_with_renegade():
	kill_priest()
	show_bloody_hand.emit()
	
func _on_pirate_dialogue_ended_with_paragon():
	sprite_2d.play("pirate_sleeping")
	collision_shape_2d_talk.disabled = true
	show_leg.emit()

func _on_pirate_dialogue_ended_with_renegade():
	sprite_2d.play("pirate_dead")
	collision_shape_2d_talk.disabled = true
	show_bloody_leg.emit()

func _process(_delta: float) -> void:
	pass
	
func kill_priest():
	sprite_2d.play("priest_dead")
	collision_shape_2d_talk.disabled = true
	
