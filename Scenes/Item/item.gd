extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var item: Node2D = $"."
@onready var collision_shape_2d: CollisionShape2D = $InteractionArea/CollisionShape2D

signal item_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"_on_interact")

func _on_interact():
	print("collected ", item.name)
	item_collected.emit(item.name)
	queue_free()
	
func enableCollisionArea():
	collision_shape_2d.disabled = false
