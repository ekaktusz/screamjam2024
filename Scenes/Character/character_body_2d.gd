extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var point_light_2d_no_shadows: PointLight2D = $Sprite2D/PointLight2D2
@onready var point_light_2d: PointLight2D = $Sprite2D/PointLight2D
@export var sfx_steps: AudioStreamPlayer
const SPEED = 150

const UP_RIGHT: Vector2 = Vector2(0.707107, -0.707107)
const UP_LEFT:  Vector2 = Vector2(-0.707107, -0.707107)
const DOWN_RIGHT:Vector2 = Vector2(0.707107, 0.707107)
const DOWN_LEFT:Vector2 = Vector2(-0.707107, 0.707107)

var hasBodyPart = false
func _physics_process(_delta):
	if Globals.player_movement_blocked:
		return
	
	# Using custom movement actions
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * SPEED
		if sfx_steps.playing == false:
			sfx_steps.play()
	else:
		sfx_steps.stop()
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

func switch_player_light(onOff:bool):
	point_light_2d.enabled = onOff
	point_light_2d_no_shadows.enabled =onOff
	
