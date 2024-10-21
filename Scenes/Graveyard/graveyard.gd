extends Node2D

@onready var lantern: Node2D = $Lantern

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lantern.item_collected.connect(_on_lantern_collected)
	
func _on_lantern_collected():
	print("lantern collected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_lantern_item_collected(item_name) -> void:
	Globals.inventory.append(item_name)
	print(item_name)
	Globals.current_objective = "bring the lantern to the grave digger"
