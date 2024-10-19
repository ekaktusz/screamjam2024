extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_interact():
	print('item picked up')
	queue_free()
