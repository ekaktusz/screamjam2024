extends MarginContainer

@onready var letter_display_timer: Timer = $CanvasLayer/LetterDisplayTimer
@onready var text_label: Label = $CanvasLayer/TextMarginContainer/TextLabel

@export var MAX_WIDTH = 256

var text_to_display: String = ""
var current_letter_index = 0

var letter_time_seconds: float = 0.03
#var space_time_seconds: float = 0.03
#var punctuation_time_seconds: float = 0.03

signal finished_displaying()

func _ready() -> void:
	z_index = 100

func display_text(text: String) -> void:
	self.text_to_display = text
	text_label.text = self.text_to_display
	
	await resized
	self.custom_minimum_size.x = min(self.size.x, MAX_WIDTH)
	
	if (self.size.x > MAX_WIDTH):
		self.text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # x resize
		await resized # y resized
		self.custom_minimum_size.y = self.size.y
		
	self.global_position.x -= self.size.x / 2
	self.global_position.y -= size.y + 24
	
	#self.text_label.text = ""
	_display_next_letter()
	
func _display_next_letter() -> void:
	# self.text_label.text += self.text_to_display[current_letter_index]
	self.text_label.visible_characters += 1
	
	if self.text_label.visible_characters >= text_to_display.length():
		finished_displaying.emit()
		return
		
	letter_display_timer.start(letter_time_seconds)
			
			
func _on_letter_display_timer_timeout() -> void:
	_display_next_letter()
