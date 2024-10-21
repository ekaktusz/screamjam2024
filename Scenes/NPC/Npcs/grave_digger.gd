extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var dog: CharacterBody2D = $"../Dog"
@onready var dog_bark_timer: Timer = $DogBarkTimer

const grave_digger_starter_dialogue: Array[String] = [
	"We lost our lantern somewhere in the cemetery!",
	"Without that, we can't bury this beautiful creature…",
	"Look at his face, as if it was sculpted by some old master... ",
	"Anyway: can you please help us find our lantern?",
	"We can't go in, we're just too afraid, am I right, Woofy?",
	"We can offer you something in return.",
	"Maybe some flowers from this nice grave? Or what would you like to have?"
]

const dog_dialogue: Array[String] = [
	"Woof!"
]

const grave_digger_paragon_answer_dialogue: Array[String] = [
	"What????",
	"You want the head?!",
	"What the…",
	"Never mind. No wisdom like silence! I-I-I guess you can have the head…",
	"He won't need it anymore, am I right, Woofie?",
	"But first, bring us the lantern! It must be somewhere in there!"
]

const grave_digger_ending_dialogue: Array[String] = [
	"Oh my goodness, you have found it! Please accept my eternal gratitude and…",
	"GRAHHH <cuts head placeholder xd>",
	" …this gorgeous head! Goodbye, sweet lady!"
]

var paragon_choice_text: String =  "😇 ask for the head of the beautiful man 🥺"
var renegade_choice_text: String = "💀 just finish the old fool 😈"

func get_random_busy_dialogue() -> Array[String]:
	var choices: Array[String] = [
		"We're quite busy burying… Right, Woofy?",
		"It's starting to get really dark… I'm not even sure I can finish this before dawn.",
		"I'm a grave-digger. I'm digging graves. That's what I do.",
		"It's so good to have you, Woofy. I don't know what I'd do without you."
	]
	return [choices[randi() % choices.size()]]

var grave_digger_dialogue_manager: DialogueManager
var dog_dialogue_manager: DialogueManager
var index_where_dog_should_woof: int = 3
# 
# 
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	_init_grave_digger_starting_dialogue()
	_init_dog_dialogue()
	
	
func _init_grave_digger_starting_dialogue() -> void:
	grave_digger_dialogue_manager = DialogueManager.create(global_position, grave_digger_starter_dialogue, paragon_choice_text, renegade_choice_text)
	add_child(grave_digger_dialogue_manager)
	grave_digger_dialogue_manager.dialogue_ended.connect(_on_grave_digger_dialogue_ended)
	grave_digger_dialogue_manager.dialogue_ended_with_paragon.connect(_on_grave_digger_dialogue_ended_with_paragon)
	grave_digger_dialogue_manager.dialogue_ended_with_renegade.connect(_on_grave_digger_dialogue_ended_with_renegade)

func _init_dog_dialogue() -> void:
	dog_dialogue_manager = DialogueManager.create(dog.global_position - Vector2(-20, -40), dog_dialogue)
	add_child(dog_dialogue_manager)
	
	# Set up the timer
	dog_bark_timer.one_shot = true
	dog_bark_timer.wait_time = 2.0
	dog_bark_timer.timeout.connect(_on_dog_bark_timer_timeout)

func _init_grave_digger_paragon_dialogue() -> void:
	grave_digger_dialogue_manager.reset_dialogue(grave_digger_paragon_answer_dialogue)

func _on_interact() -> void:
	if Globals.inventory.has("Lantern") and grave_digger_dialogue_manager.dialogue_lines != grave_digger_ending_dialogue:
		grave_digger_dialogue_manager.reset_dialogue(grave_digger_ending_dialogue)
	
	grave_digger_dialogue_manager.start_dialogue()
	Globals.player_movement_blocked = true
	if grave_digger_dialogue_manager.current_line_index == index_where_dog_should_woof and not dog_dialogue_manager.is_dialogue_active:
		print(grave_digger_dialogue_manager.current_line_index)
		dog_bark_timer.start()

func _on_dog_bark_timer_timeout() -> void:
	dog_dialogue_manager.start_dialogue()

func _on_grave_digger_dialogue_ended() -> void:
	print("grave digger dialogue ended")
	Globals.player_movement_blocked = false
	
	if grave_digger_dialogue_manager.dialogue_lines == grave_digger_ending_dialogue:
		print(Globals.inventory)
		Globals.inventory.erase("Lantern")
		print(Globals.inventory)
		Globals.inventory.append("Head")
		queue_free()
		return
	
	if grave_digger_dialogue_manager.dialogue_lines != grave_digger_starter_dialogue:
		grave_digger_dialogue_manager.reset_dialogue(get_random_busy_dialogue())
	
func _on_grave_digger_dialogue_ended_with_paragon() -> void:
	print("grave digger dialogue ended w paragon")
	Globals.current_objective = "find the lantern"
	Globals.player_movement_blocked = false
	_init_grave_digger_paragon_dialogue()
	grave_digger_dialogue_manager.start_dialogue()

func _on_grave_digger_dialogue_ended_with_renegade() -> void:
	print("grave digger dialogue ended w renegade")
	queue_free() # TODO: killlllll
	Globals.player_movement_blocked = false

func _process(delta: float) -> void:
	pass
