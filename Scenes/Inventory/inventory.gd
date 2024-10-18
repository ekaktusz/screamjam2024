extends Control

var inventory: Array[Bodypart] = [
	Bodypart.new("Head", false),
	Bodypart.new("Torso", false),
	Bodypart.new("RightArm", false),
	Bodypart.new("LeftArm", false),
	Bodypart.new("RightLeg", false),
	Bodypart.new("LeftLeg", false),
]

func collect_item(name: String):
	for part in inventory:
		if part.get_bodypart() == name:
			part.is_collected = true
			
			print("%s has been collected." % name)
			for item in inventory:
				print (item._to_string())
