extends Node2D

@onready var lantern: Node2D = $Lantern
@onready var head: Node2D = $Head
@onready var head_bloody: Node2D = $HeadBloody
@export var sfx_item: AudioStreamPlayer
signal head_collected_on_graveyard
#signal head_bloody_collected_on_graveyard

func _on_lantern_item_collected(item_name) -> void:
	Globals.inventory.append(item_name)
	sfx_item.play()
	if !Globals.inventory.has("Head") && !Globals.inventory.has("HeadBloody") :
		Globals.current_objective = "Bring the lantern to the grave digger"

func _on_show_head_bloody() -> void:
	head_bloody.visible = true
	head_bloody.enableCollisionArea()

func _on_show_head() -> void:
	head.visible = true 
	head.enableCollisionArea()

func _on_head_item_collected(item) -> void:
	sfx_item.play()
	head_collected_on_graveyard.emit(item)

#func _on_head_bloody_item_collected(item) -> void:
	#head_bloody_collected_on_graveyard.emit(item)
