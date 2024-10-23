extends CanvasLayer

@onready var margin_container = $MarginContainer
@onready var letter_display_timer: Timer = $MarginContainer/LetterDisplayTimer
@onready var text_label: Label = $MarginContainer/TextMarginContainer/TextLabel
@export var MAX_WIDTH = 600
@export var PIXEL_SCALE = 1  # Integer scaling factor

var text_to_display: String = ""
var current_letter_index = 0
var letter_time_seconds: float = 0.03
var target_position: Vector2

signal finished_displaying()

func _ready() -> void:
	layer = 100
	_setup_pixel_perfect()

func _setup_pixel_perfect() -> void:
	# Set nearest neighbor filtering on the main container and all its children
	margin_container.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	for child in margin_container.get_children():
		if child is CanvasItem:
			child.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	# Scale the margin container
	margin_container.scale = Vector2(PIXEL_SCALE, PIXEL_SCALE)
	
	# Set up text settings
	if text_label.label_settings == null:
		text_label.label_settings = LabelSettings.new()
	text_label.label_settings.font_size = 55  # Base size before scaling

func _process(_delta: float) -> void:
	if margin_container:
		var viewport = get_viewport()
		if viewport:
			var screen_position = viewport.get_canvas_transform() * target_position
			# Compensate for the container scale in positioning
			# screen_position = screen_position / PIXEL_SCALE
			# screen_position = screen_position.round()
			margin_container.global_position = screen_position
			margin_container.global_position.x -= margin_container.size.x / 2
			margin_container.global_position.y -= margin_container.size.y + 24


# Call this when setting position from DialogueManager
func set_target_position(pos: Vector2) -> void:
	target_position = pos

func display_text(text: String) -> void:
	self.text_to_display = text
	text_label.text = self.text_to_display
	
	await margin_container.resized
	margin_container.custom_minimum_size.x = min(margin_container.size.x, MAX_WIDTH)
	
	if (margin_container.size.x > MAX_WIDTH):
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await margin_container.resized # x resize
		await margin_container.resized # y resized
		margin_container.custom_minimum_size.y = margin_container.size.y
	
	display_next_letter()

# ... rest of the code remains the same ...
func display_next_letter() -> void:
	text_label.visible_characters += 1
	
	if text_label.visible_characters >= text_to_display.length():
		finished_displaying.emit()
		return
		
	letter_display_timer.start(letter_time_seconds)

func _on_letter_display_timer_timeout() -> void:
	display_next_letter()
