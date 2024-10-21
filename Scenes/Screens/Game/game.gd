extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var directional_light_2d: DirectionalLight2D = $DirectionalLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InteractionManager.set_player(player)
	#dark_mode_switch()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#call this when entering dark area
func dark_mode_switch():
	directional_light_2d.enabled = !directional_light_2d.enabled
	player.switch_player_light()
	
