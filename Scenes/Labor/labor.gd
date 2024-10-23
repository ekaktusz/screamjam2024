extends Node2D

signal torso_collected_in_labor
@onready var collision_shape_2d: CollisionShape2D = $InteractionArea/CollisionShape2D

func _ready() -> void:
	collision_shape_2d.disabled = true

func _process(delta: float) -> void:
	if ((Globals.inventory.has("Head") or Globals.inventory.has("HeadBloody")) and
	   (Globals.inventory.has("Hands") or Globals.inventory.has("HandsBloody")) and
	   (Globals.inventory.has("Leg") or Globals.inventory.has("LegBloody")) and
	   (Globals.inventory.has("Torso") and collision_shape_2d.disabled)):
		collision_shape_2d.disabled = false

func _on_item_collected(item) -> void:
	torso_collected_in_labor.emit(item)
