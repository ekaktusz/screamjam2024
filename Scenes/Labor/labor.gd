extends Node2D

@onready var photo_interaction_area: InteractionArea = $PhotoInteractionArea
@onready var collision_shape_2d: CollisionShape2D = $PhotoInteractionArea/CollisionShape2D
signal torso_collected_in_labor

func _ready() -> void:
	photo_interaction_area.interact = Callable(self,"_on_photo_interact")
	collision_shape_2d.disabled = true

func _process(delta: float) -> void:
	if ((Globals.inventory.has("Head") or Globals.inventory.has("HeadBloody")) and
	   (Globals.inventory.has("Hands") or Globals.inventory.has("HandsBloody")) and
	   (Globals.inventory.has("Leg") or Globals.inventory.has("LegBloody")) and
	   (Globals.inventory.has("Torso") and collision_shape_2d.disabled)):
		collision_shape_2d.disabled = false
		
func _on_photo_interact():
	ScreenManager.change_screen("res://Scenes/Labor/ending_photo.tscn")

func _on_item_collected(item) -> void:
	torso_collected_in_labor.emit(item)
