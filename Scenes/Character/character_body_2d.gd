extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var inventory: Control = $Inventory
const SPEED = 200

const UP_RIGHT: Vector2 = Vector2(0.707107, -0.707107)
const UP_LEFT:  Vector2 = Vector2(-0.707107, -0.707107)
const DOWN_RIGHT:Vector2 = Vector2(0.707107, 0.707107)
const DOWN_LEFT:Vector2 = Vector2(-0.707107, 0.707107)

var hasBodyPart = false

func _physics_process(_delta):
	
	var	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction: 
		self.velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	set_anim_by_direction(direction)
	move_and_slide()

func set_anim_by_direction(direction: Vector2):
	if direction == Vector2.DOWN:
		sprite_2d.play("down")
	elif direction == Vector2.UP:
		sprite_2d.play("up")
	elif direction == Vector2.LEFT:
		sprite_2d.play("left")
	elif direction == Vector2.RIGHT:
		sprite_2d.play("right")
	elif direction.angle() == UP_RIGHT.angle():
		sprite_2d.play("up_right")
	elif direction.angle() == UP_LEFT.angle():
		sprite_2d.play("up_left")
	elif direction.angle() == DOWN_RIGHT.angle():
		sprite_2d.play("down_right")
	elif direction.angle() == DOWN_LEFT.angle():
		sprite_2d.play("down_left")
	
func _input(event):
	if event.is_action_pressed("open_inventory"):
		inventory.visible = !inventory.visible

func _on_item_collected(interacted_name) -> void:
	inventory.collect_item(interacted_name)
