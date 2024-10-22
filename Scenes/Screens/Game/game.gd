extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var directional_light_2d: DirectionalLight2D = $DirectionalLight2D

@onready var hud: Node2D = $Hud

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InteractionManager.set_player(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#call this when entering dark area
func dark_mode_switch():
	directional_light_2d.enabled = !directional_light_2d.enabled
	player.switch_player_light()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered")
	if body.is_in_group("player"):
		dark_mode_switch()

func _on_item_collected(item_name) -> void:
	print("game item collected")
	Globals.current_objective = "speak with the grave digger"
	Globals.inventory.append(item_name)
