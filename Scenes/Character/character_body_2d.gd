extends CharacterBody2D

const lines:  Array[String] = [
	"Aasdasdad asd dfghdg erte ! g dfgd +",
	" asdasd gggdgffd d",
	" asdas ..... "
]

const SPEED = 200
var hasBodyPart = false

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		DialogueManager.start_dialog(Vector2(50, 50), lines)


func _physics_process(_delta):
	
	var	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction: 
		self.velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
