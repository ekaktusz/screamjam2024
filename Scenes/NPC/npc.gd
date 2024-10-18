extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

const lines:  Array[String] = [
	"Aasdasdad asd dfghdg erte ! g dfgd +",
	" asdasd gggdgffd d",
	" asdas ..... "
]

var dialogue_manager: DialogueManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")
	dialogue_manager = DialogueManager.create(global_position, lines)
	add_child(dialogue_manager)
	
func _on_interact():
	dialogue_manager.start_dialogue()
	dialogue_manager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_dialogue_ended():
	print("test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
