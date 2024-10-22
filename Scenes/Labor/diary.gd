extends CanvasLayer

@onready var grannys_diary: Sprite2D = $GrannysDiary
@onready var o_kbutton: Button = $OKbutton

func _ready() -> void:
	Globals.player_movement_blocked = true
	
	# Start with fully transparent elements and disabled button
	grannys_diary.modulate.a = 0
	o_kbutton.modulate.a = 0
	o_kbutton.disabled = true
	
	# Create fade-in tween for both elements
	var tween = create_tween()
	tween.parallel().tween_property(grannys_diary, "modulate:a", 1.0, 0.5)  # Fade in sprite
	tween.parallel().tween_property(o_kbutton, "modulate:a", 1.0, 0.5)      # Fade in button
	
	# Create a timer for enabling the button
	var timer = get_tree().create_timer(3.0)
	timer.timeout.connect(_on_timer_timeout)
	
	# Connect the button press
	o_kbutton.pressed.connect(_on_button_pressed)

func _on_timer_timeout() -> void:
	# Just enable the button (it's already visible)
	o_kbutton.disabled = false

func _on_button_pressed() -> void:
	# Disable the button to prevent multiple clicks during fade out
	o_kbutton.disabled = true
	
	# Create fade out tween
	var tween = create_tween()
	tween.parallel().tween_property(grannys_diary, "modulate:a", 0.0, 0.5)  # Fade out sprite
	tween.parallel().tween_property(o_kbutton, "modulate:a", 0.0, 0.5)      # Fade out button
	tween.tween_callback(_on_fade_out_finsihed)  # Remove the scene after fade out

func _on_fade_out_finsihed():
	Globals.player_movement_blocked = false
	queue_free()
