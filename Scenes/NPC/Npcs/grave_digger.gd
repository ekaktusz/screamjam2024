extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea

@onready var dog: CharacterBody2D = $"../Dog"

const GRAVE_DIGGER_DIALOGUE_LINES:  Array[String] = [
	"We lost our lantern somewhere in the cemetery!",
	"Without that, we can’t bury this beautiful creature…",
	"Look at his face, as if it was sculpted by some old master... ",
	"Anyway: can you please help us find our lantern?",
	"We can’t go in, we’re just too afraid, am I right, Woofy?",
	"We can offer you something in return.",
	"Maybe some flowers from this nice grave? Or what would you like to have?"
]

const DOG_DIALOGUE_LINES:  Array[String] = [
	"Woof!"
]

var grave_digger_dialogue_manager: DialogueManager
var dog_dialogue_manager: DialogueManager

var index_where_dog_should_woof: int = 4

func _ready() -> void:
		interaction_area.interact = Callable(self,"_on_interact")
		grave_digger_dialogue_manager = DialogueManager.create(global_position, GRAVE_DIGGER_DIALOGUE_LINES)
		add_child(grave_digger_dialogue_manager)
		grave_digger_dialogue_manager.dialogue_ended.connect(_on_grave_digger_dialogue_ended)
		dog_dialogue_manager = DialogueManager.create(dog.global_position - Vector2(-20, -40), DOG_DIALOGUE_LINES)
		add_child(dog_dialogue_manager)

func _on_interact():
	grave_digger_dialogue_manager.start_dialogue()
	if (grave_digger_dialogue_manager.current_line_index == index_where_dog_should_woof):
		dog_dialogue_manager.start_dialogue()
	
func _on_grave_digger_dialogue_ended():
	print("grave digger dilaogue ended")

func _process(_delta: float) -> void:
	pass
