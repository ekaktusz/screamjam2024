extends Node2D
@onready var hands_bloody: Node2D = $HandsBloody
@onready var hands: Node2D = $Hands
@onready var leg: Node2D = $Leg
@onready var leg_bloody: Node2D = $LegBloody

signal arm_collected_on_main_square
signal arm_bloody_collected_on_main_square
signal leg_collected_on_main_square
signal leg_bloody_collected_on_main_square

func _on_hands_bloody_item_collected(item) -> void:
	print("bloody arm collected main square", item)
	hands.queue_free()
	arm_bloody_collected_on_main_square.emit(item)

func _on_hands_item_collected(item) -> void:
	print("arm collected main square", item)
	arm_collected_on_main_square.emit(item)

func _on_leg_item_collected(item) -> void:
	print("leg collected main square", item)
	leg_collected_on_main_square.emit(item)

func _on_leg_bloody_item_collected(item) -> void:
	print("bloody leg collected main square", item)
	leg_bloody_collected_on_main_square.emit(item)

func _on_show_bloody_hand() -> void:
	hands_bloody.visible = true
	hands_bloody.enableCollisionArea()

func _on_show_hand() -> void:
	hands.visible = true 
	hands.enableCollisionArea()
