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
#func dark_mode_switch():
	#directional_light_2d.enabled = !directional_light_2d.enabled
	#player.switch_player_light()
	
func dark_mode_on():
	directional_light_2d.enabled = true
	player.switch_player_light(true)

func dark_mode_off():
	directional_light_2d.enabled = false
	player.switch_player_light(false)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dark_mode_off()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		dark_mode_on()

#torso item collected
func _on_torso_collected(item_name) -> void:
	Globals.current_objective = "Look around for somebody who could miss a leg"
	Globals.inventory.append(item_name)
	#todo "open door" to main square
	
func _on_leg_bloody_collected(item_name) -> void:
	#todo add objective logic
	#kill pirate with anim
	Globals.current_objective = "Pray for a hand - or two"
	Globals.inventory.append(item_name)

func _on_leg_collected_on_main_square(item_name) -> void:
	#let pirate sleep with anim
	Globals.current_objective = "Pray for a hand - or two"
	Globals.inventory.append(item_name)

func _on_arm_collected(item_name) -> void:
	#disable other hand collection FROM PRIEST and move to next quest
	Globals.current_objective = "Speak with the grave digger"
	Globals.inventory.append(item_name)
	#todo "open door" to the graveyard

func _on_arm_bloody_collected(item_name) -> void:
	Globals.current_objective = "Speak with the grave digger"
	Globals.inventory.append(item_name)
	#todo "open door" to the graveyard

#func _on_head_bloody_collected(item_name) -> void:
	#Globals.inventory.append(item_name)

func _on_head_collected(item_name) -> void:
	Globals.current_objective = "Return to the Labor to stitch together your new BF"
	Globals.inventory.append(item_name)
