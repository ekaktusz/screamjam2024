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
const DOG_DIALOGUE_LINES: Array[String] = [
	"Woof!"
]



var grave_digger_dialogue_manager: DialogueManager
var dog_dialogue_manager: DialogueManager
var index_where_dog_should_woof: int = 3

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	grave_digger_dialogue_manager = DialogueManager.create(global_position, grave_digger_starter_dialogue)
	add_child(grave_digger_dialogue_manager)
	grave_digger_dialogue_manager.dialogue_ended.connect(_on_grave_digger_dialogue_ended)
	dog_dialogue_manager = DialogueManager.create(dog.global_position - Vector2(-20, -40), DOG_DIALOGUE_LINES)
	add_child(dog_dialogue_manager)
	
	# Set up the timer
	dog_bark_timer.one_shot = true
	dog_bark_timer.wait_time = 2.0
	dog_bark_timer.timeout.connect(_on_dog_bark_timer_timeout)

func _on_interact():
	grave_digger_dialogue_manager.start_dialogue()
	if grave_digger_dialogue_manager.current_line_index == index_where_dog_should_woof:
		dog_bark_timer.start()

func _on_dog_bark_timer_timeout():
	dog_dialogue_manager.start_dialogue()

func _on_grave_digger_dialogue_ended():
	print("grave digger dialogue ended")
	Globals.current_objective = "find the lantern in the graveyard"

func _process(delta: float) -> void:
	pass
