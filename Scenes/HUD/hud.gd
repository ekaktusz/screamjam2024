extends Node2D

@onready var objective_text: Label = $CanvasLayer/CurrentObjective/ObjectiveText


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Globals != null):
		objective_text.text = Globals.current_objective
