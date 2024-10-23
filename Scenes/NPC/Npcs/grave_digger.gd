extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var dog: CharacterBody2D = $"../Dog"
@onready var dog_bark_timer: Timer = $DogBarkTimer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d_talk: CollisionShape2D = $InteractionArea/CollisionShape2D

@export var sfx_knife: AudioStreamPlayer
@export var sfx_scream: AudioStreamPlayer

signal show_head
signal show_head_bloody

var grave_digger_dialogue_manager: DialogueManager
var dog_dialogue_manager: DialogueManager
var index_where_dog_should_woof: int = 3

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	_init_grave_digger_starting_dialogue()
	_init_dog_dialogue()
	
func _init_grave_digger_starting_dialogue() -> void:
	grave_digger_dialogue_manager = DialogueManager.create(global_position - Vector2(0, 32), DialogueDb.grave_digger_starter_dialogue, DialogueDb.grave_digger_paragon_choice_text,  DialogueDb.grave_digger_renegade_choice_text)
	add_child(grave_digger_dialogue_manager)
	grave_digger_dialogue_manager.dialogue_ended.connect(_on_grave_digger_dialogue_ended)
	grave_digger_dialogue_manager.dialogue_ended_with_paragon.connect(_on_grave_digger_dialogue_ended_with_paragon)
	grave_digger_dialogue_manager.dialogue_ended_with_renegade.connect(_on_grave_digger_dialogue_ended_with_renegade)

func _init_dog_dialogue() -> void:
	dog_dialogue_manager = DialogueManager.create(dog.global_position - Vector2(0, 10),  DialogueDb.grave_digger_dog_dialogue)
	add_child(dog_dialogue_manager)
	
	dog_bark_timer.one_shot = true
	dog_bark_timer.wait_time = 2.0
	dog_bark_timer.timeout.connect(_on_dog_bark_timer_timeout)

func _on_dog_bark_timer_timeout() -> void:
	dog_dialogue_manager.start_dialogue()
	
func _on_interact() -> void:
	if Globals.inventory.has("Lantern") and grave_digger_dialogue_manager.dialogue_lines !=  DialogueDb.grave_digger_ending_dialogue:
		grave_digger_dialogue_manager.reset_dialogue(DialogueDb.grave_digger_ending_dialogue)
	
	grave_digger_dialogue_manager.start_dialogue()
	Globals.player_movement_blocked = true
	if grave_digger_dialogue_manager.current_line_index == index_where_dog_should_woof and not dog_dialogue_manager.is_dialogue_active:
		print(grave_digger_dialogue_manager.current_line_index)
		dog_bark_timer.start()

func _on_grave_digger_dialogue_ended() -> void:
	print("grave digger dialogue ended")
	Globals.player_movement_blocked = false
	
	if grave_digger_dialogue_manager.dialogue_lines == DialogueDb.grave_digger_ending_dialogue:
		Globals.inventory.erase("Lantern")
		sfx_knife.play()
		show_head.emit()
		collision_shape_2d_talk.disabled = true
		return
	
	if grave_digger_dialogue_manager.dialogue_lines !=  DialogueDb.grave_digger_starter_dialogue:
		grave_digger_dialogue_manager.reset_dialogue(DialogueDb.get_grave_digger_random_busy_dialogue())
		
func _on_grave_digger_dialogue_ended_with_paragon() -> void:
	print("grave digger dialogue ended w paragon")
	Globals.current_objective = "Find the lantern"
	grave_digger_dialogue_manager.reset_dialogue(DialogueDb.grave_digger_paragon_answer_dialogue)
	grave_digger_dialogue_manager.start_dialogue()

func _on_grave_digger_dialogue_ended_with_renegade() -> void:
	print("grave digger dialogue ended w renegade")
	#Globals.current_objective = "Return to the Labor to stitch together your new BF"
	kill_grave_digger()
	show_head_bloody.emit()
	#Globals.inventory.append("HeadBloody")
	
func kill_grave_digger():
	sfx_knife.play()
	sfx_scream.play()
	sprite_2d.play("dead")
	collision_shape_2d_talk.disabled = true
	
