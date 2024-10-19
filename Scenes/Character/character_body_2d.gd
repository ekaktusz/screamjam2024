extends CharacterBody2D

@onready var inventory: Control = $Inventory
const SPEED = 200
var hasBodyPart = false


func _physics_process(_delta):
	
	var	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction: 
		self.velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

func _input(event):
	if event.is_action_pressed("open_inventory"):
		inventory.visible = !inventory.visible

func _on_item_collected(interacted_name) -> void:
	inventory.collect_item(interacted_name)
