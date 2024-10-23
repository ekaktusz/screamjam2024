extends Node2D

@onready var photo_interaction_area: InteractionArea = $PhotoInteractionArea
@onready var collision_shape_2d: CollisionShape2D = $PhotoInteractionArea/CollisionShape2D
@onready var quest_area_detect: CollisionPolygon2D = $StaticBody2D/BlockQuestArea/QuestAreaDetect
@onready var quest_area_blocker: CollisionPolygon2D = $StaticBody2D/QuestAreaBlocker
@onready var countDownBall: Sprite2D = $CountDownBall

@onready var quest_hint_label: Label = $CanvasLayer/Label
@export var sfx_item: AudioStreamPlayer

const ending_photo = preload("res://Scenes/Labor/ending_photo.tscn")

signal torso_collected_in_labor

func _ready() -> void:
	photo_interaction_area.interact = Callable(self, "_on_photo_interact")
	collision_shape_2d.disabled = true
	quest_hint_label.hide()

func _process(delta: float) -> void:
	# Check for photo interaction conditions
	if ((Globals.inventory.has("Head") or Globals.inventory.has("HeadBloody")) and
	   (Globals.inventory.has("Hands") or Globals.inventory.has("HandsBloody")) and
	   (Globals.inventory.has("Leg") or Globals.inventory.has("LegBloody")) and
	   (Globals.inventory.has("Torso") and collision_shape_2d.disabled)):
		collision_shape_2d.disabled = false
	
	# Update label position if visible
	if quest_hint_label.visible:
		var canvas_transform = get_viewport().get_canvas_transform()
		var screen_pos = canvas_transform * $StaticBody2D.global_position
		
		# Add any desired offset
		screen_pos.y -= 32  # Adjust these values as needed
		screen_pos.x -= 64  # Adjust these values as needed
		
		quest_hint_label.position = screen_pos

func _on_photo_interact():
	var node = ending_photo.instantiate()
	add_child(node)
	countDownBall.visible = true


func _on_item_collected(item) -> void:
	torso_collected_in_labor.emit(item)
	sfx_item.play()
	disable_quest_area_block()

func _on_block_quest_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label.show()

func _on_block_quest_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		quest_hint_label.hide()

func disable_quest_area_block():
	quest_area_detect.disabled = true
	quest_area_blocker.disabled = true
