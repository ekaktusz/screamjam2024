extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea


func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")


func _process(delta: float) -> void:
	pass


func _on_interact():
	print('Talking w/ NPC')
