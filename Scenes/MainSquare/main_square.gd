extends Node2D

@onready var hands_bloody: Node2D = $HandsBloody
@onready var hands: Node2D = $Hands
@onready var leg: Node2D = $Leg
@onready var leg_bloody: Node2D = $LegBloody
@onready var quest_hint_label: Label = $CanvasLayer/QuestHintLabel

@onready var quest_hint_label_priest: Label = $CanvasLayer/QuestHintLabelPriest
@onready var quest_area_detect: CollisionPolygon2D = $GraveyardAreaBlocker/BlockQuestArea/QuestAreaDetect
@onready var quest_area_blocker: CollisionPolygon2D = $GraveyardAreaBlocker/QuestAreaBlocker
@onready var quest_area_detect_priest: CollisionPolygon2D = $PriestAreaBlocker/BlockQuestArea/QuestAreaDetect
@onready var quest_area_blocker_priest: CollisionPolygon2D = $PriestAreaBlocker/QuestAreaBlocker
@export var sfx_item: AudioStreamPlayer

signal arm_collected_on_main_square
signal arm_bloody_collected_on_main_square
signal leg_collected_on_main_square
signal leg_bloody_collected_on_main_square

func _ready():
	# Set up labels with initial text and hide them
	quest_hint_label.text = "Complete the quest first!"  # Set your desired text here
	quest_hint_label_priest.text = "Talk to the priest first!"  # Set your desired text here
	quest_hint_label.hide()
	quest_hint_label_priest.hide()

func _process(_delta):
	# Update label positions if they're visible
	if quest_hint_label.visible:
		var canvas_transform = get_viewport().get_canvas_transform()
		var screen_pos = canvas_transform * $GraveyardAreaBlocker.global_position
		quest_hint_label.position = screen_pos
		
	if quest_hint_label_priest.visible:
		var canvas_transform = get_viewport().get_canvas_transform()
		var screen_pos = canvas_transform * $PriestAreaBlocker.global_position
		quest_hint_label_priest.position = screen_pos

func _on_hands_bloody_item_collected(item) -> void:
	print("bloody arm collected main square", item)
	sfx_item.play()
	hands.queue_free()
	arm_bloody_collected_on_main_square.emit(item)
	disable_quest_area_block()

func _on_hands_item_collected(item) -> void:
	sfx_item.play()
	arm_collected_on_main_square.emit(item)
	disable_quest_area_block()

func _on_leg_item_collected(item) -> void:
	sfx_item.play()
	leg_collected_on_main_square.emit(item)
	disable_priest_quest_area_block()

func _on_leg_bloody_item_collected(item) -> void:
	sfx_item.play()
	leg_bloody_collected_on_main_square.emit(item)
	disable_priest_quest_area_block()

func _on_show_bloody_hand() -> void:
	hands_bloody.visible = true
	hands_bloody.enableCollisionArea()

func _on_show_hand() -> void:
	hands.visible = true 
	hands.enableCollisionArea()

func _on_show_bloody_leg() -> void:
	leg_bloody.visible = true
	leg_bloody.enableCollisionArea()

func _on_show_leg() -> void:
	leg.visible = true
	leg.enableCollisionArea()
	
func _on_block_quest_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label.show()

func _on_block_quest_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label.hide()

func disable_quest_area_block():
	quest_area_detect.disabled = true
	quest_area_blocker.disabled = true

func disable_priest_quest_area_block():
	quest_area_detect_priest.disabled = true
	quest_area_blocker_priest.disabled = true

func _on_priest_quest_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label_priest.show()

func _on_priest_quest_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label_priest.hide()
