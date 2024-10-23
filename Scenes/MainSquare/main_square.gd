extends Node2D

@onready var hands_bloody: Node2D = $HandsBloody
@onready var hands: Node2D = $Hands
@onready var leg: Node2D = $Leg
@onready var leg_bloody: Node2D = $LegBloody

@onready var quest_hint_panel: Panel = $GraveyardAreaBlocker/Panel
@onready var quest_area_detect: CollisionPolygon2D = $GraveyardAreaBlocker/BlockQuestArea/QuestAreaDetect
@onready var quest_area_blocker: CollisionPolygon2D = $GraveyardAreaBlocker/QuestAreaBlocker

@onready var quest_hint_panel_priest: Panel = $PriestAreaBlocker/Panel
@onready var quest_area_detect_priest: CollisionPolygon2D = $PriestAreaBlocker/BlockQuestArea/QuestAreaDetect
@onready var quest_area_blocker_priest: CollisionPolygon2D = $PriestAreaBlocker/QuestAreaBlocker

@export var sfx_item: AudioStreamPlayer

signal arm_collected_on_main_square
signal arm_bloody_collected_on_main_square
signal leg_collected_on_main_square
signal leg_bloody_collected_on_main_square

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
	print(body)
	if body.name == "Player":
		quest_hint_panel.visible = true

func _on_block_quest_area_body_exited(body: Node2D) -> void:
	print(body)
	if body.name == "Player":
		quest_hint_panel.visible = false

func disable_quest_area_block():
	quest_area_detect.disabled = true
	quest_area_blocker.disabled = true

func disable_priest_quest_area_block():
	quest_area_detect_priest.disabled = true
	quest_area_blocker_priest.disabled = true

func _on_priest_quest_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_panel_priest.visible = true

func _on_priest_quest_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_panel_priest.visible = false
