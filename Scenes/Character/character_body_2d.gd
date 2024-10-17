extends CharacterBody2D


const SPEED = 200

func _physics_process(delta):
	
	var	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction: 
		self.velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
