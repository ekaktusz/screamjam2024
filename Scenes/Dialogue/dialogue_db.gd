extends Node

### GRAVE DIGGER DIALOGUES

const grave_digger_starter_dialogue: Array[String] = [
	"We lost our lantern somewhere in the cemetery!",
	"Without that, we can't bury this beautiful creature…",
	"Look at his face, as if it was sculpted by some old master... ",
	"Anyway: can you please help us find our lantern?",
	"We can't go in, we're just too afraid, am I right, Woofy?",
	"We can offer you something in return.",
	"Maybe some flowers from this nice grave? Or what would you like to have?"
]

const grave_digger_paragon_choice_text: String =  "😇 ask for the head of the beautiful man 🥺"
const grave_digger_renegade_choice_text: String = "💀 just finish the old fool 😈"

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
		"I'm a grave-digger. I'm digging graves. That's what I do.",
		"It's so good to have you, Woofy. I don't know what I'd do without you."
	]
	return [choices[randi() % choices.size()]]

const grave_digger_ending_dialogue: Array[String] = [
	"Oh my goodness, you have found it! Please accept my eternal gratitude and…",
	"GRAHHH <cuts head placeholder xd>",
	" …this gorgeous head! Goodbye, sweet lady!"
]

const  grave_digger_dog_dialogue: Array[String] = [
	"Woof!"
]

##PRIES DIALOGUES 

const priest_starter_dialogue: Array[String] = [
	"How may I serve you my child?",
	"What? A hand?",
	"You mean the Holy Hand of Saint Hilarius?",
	"O give me your hand, give me your hand. All I want is the love of God.",
	"Give me your hand, give me your hand. You must be loving at God’s command."
]

const priest_paragon_dialogue:Array[String] = [
	" I gotta hand it to you, this was a finger-licking good idea!"
]

const priest_paragon_choice_text: String =  "😇 pray with the priest 🥺"
const priest_renegade_choice_text: String = "💀 you've hand enough 😈"
