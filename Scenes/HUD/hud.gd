extends Node2D

@onready var objective_text: Label = $CanvasLayer/CurrentObjective/ObjectiveText
@onready var inventory: Control = $CanvasLayer/Inventory

var previous_objective: String = ""
var effect_timer: float = 0.0
var original_scale: Vector2
const EFFECT_DURATION: float = 1.0  # Duration of the effect in seconds
const MAX_GLOW: float = 2.0  # Maximum glow intensity
const SCALE_MULTIPLIER: float = 1.2  # How much to scale up during the pop effect

func _ready() -> void:
	# Initialize the previous objective and original scale
	if Globals != null:
		previous_objective = Globals.current_objective
	original_scale = objective_text.scale
	
	# Add a modulate effect shader to the text
	objective_text.modulate = Color(1, 1, 1, 1)

func _process(delta: float) -> void:
	if Globals != null:
		if previous_objective != Globals.current_objective:
			# Objective changed, start the effect
			effect_timer = EFFECT_DURATION
			previous_objective = Globals.current_objective
			
			# Create scale animation
			var tween = create_tween()
			tween.set_parallel(true)  # Allow multiple properties to animate at once
			
			# Scale up quickly
			tween.tween_property(objective_text, "scale", 
				original_scale * SCALE_MULTIPLIER, 0.1)
			# Scale back to normal
			tween.chain().tween_property(objective_text, "scale", 
				original_scale, 0.2)
		
		objective_text.text = Globals.current_objective
		
		# Handle the glow effect
		if effect_timer > 0:
			effect_timer -= delta
			var effect_progress = effect_timer / EFFECT_DURATION
			
			# Calculate glow and fade
			var glow = 1.0 + (MAX_GLOW * effect_progress)
			
			# Apply the glow effect
			objective_text.modulate = Color(glow, glow, glow, 1.0)
		else:
			# Reset to normal state
			objective_text.modulate = Color(1, 1, 1, 1)

func _input(event):
	if event.is_action_pressed("open_inventory"):
		inventory.visible = !inventory.visible
