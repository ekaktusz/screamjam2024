extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

const lines:  Array[String] = [
	"Aasdasdad asd dfghdg erte ! g dfgd +",
	" asdasd gggdgffd d",
	" asdas ..... "
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")
	
func _on_interact():
	DialogueManager.start_dialog(global_position, lines)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
