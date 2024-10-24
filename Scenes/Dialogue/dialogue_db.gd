extends Node

### GRAVE DIGGER DIALOGUES

const grave_digger_starter_dialogue: Array[String] = [
	"We lost our lantern somewhere in the cemetery!",
	"Without that, we can't keep on burying…",
	"Here lies a gorgeous man. Women used to lose their heads over him...",
	"Anyway: can you please help us find our lantern?",
	"We can't go in, we're just too afraid, am I right, Woofy?",
	"We can offer you something in return."
]

const grave_digger_paragon_choice_text: String =  "Ask for the gorgeous head from the grave"
const grave_digger_renegade_choice_text: String = "Just finish the old fool"

const grave_digger_paragon_answer_dialogue: Array[String] = [
	"What????",
	"You want the head?!",
	"What the…",
	"Never mind. No wisdom like silence! I-I-I guess you can have the head…",
	"He won't need it anymore, am I right, Woofie?",
	"But first, bring us the lantern! It must be somewhere in there!"
]

func get_grave_digger_random_busy_dialogue() -> Array[String]:
	const choices: Array[String] = [
		"We're quite busy burying… Right, Woofy?",
		"It's starting to get really dark… I'm not even sure I can finish this before dawn.",
		"I'm a gravedigger. I'm digging graves. That's what I do.",
		"It's so good to have you, Woofy. I don't know what I'd do without you."
	]
	return [choices[randi() % choices.size()]]

const grave_digger_ending_dialogue: Array[String] = [
	"Oh my goodness, you have found it! Please accept my eternal gratitude and…",
	"GRAHHH <gave digger cuts off the head>",
	" …this gorgeous head! Goodbye, sweet lady!"
]

const  grave_digger_dog_dialogue: Array[String] = [
	"Woof!"
]
## PRIEST DIALOGUES 

const priest_starter_dialogue: Array[String] = [
	"How may I serve you my child?",
	"What? A hand?",
	"You mean the Holy Hand of Saint Hilarius?"
]

const priest_paragon_dialogue:Array[String] = [
	"O give me your hand, give me your hand. All I want is the love of God.",
	"Give me your hand, give me your hand. You must be loving at God’s command.",
	" I gotta hand it to you, this was a finger-licking good idea!",
]

const priest_paragon_choice_text: String =  "Pray with the priest"
const priest_renegade_choice_text: String = "You've hand enough"


## PIRATE DIALOGUES
const pirate_starter_dialogue: Array[String] = [
	"Z..ZZZ..ZZ",
	"Z..ZZ",
	"ZZZ..Z..ZZ..ZZ.Z...ZZ"
]

const pirate_paragon_choice_text: String =  "Take the wooden leg"
const pirate_renegade_choice_text: String = "Cut his leg, you need it more"
