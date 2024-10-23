extends CanvasLayer

# Tweening durations
var flash_in_duration: float = 0.2
var flash_hold_duration: float = 0.2
var flash_out_duration: float = 0.5
var photo_fade_duration: float = 1.2
var ui_fade_duration: float = 0.5
var button_enable_delay: float = 3.0

@onready var ending_photo: Sprite2D = $EndingPhoto
@onready var ok_button: Button = $OKButton
@onready var photo_background: Sprite2D = $PhotoBackground
@onready var label: Label = $Label
@onready var flash_overlay: ColorRect = $FlashOverlay  # Add this node in the scene

var ending_textures = {
    "ending1_texture": preload("res://Scenes/Labor/assets/ending1.png"),
    "ending2_texture": preload("res://Scenes/Labor/assets/ending2.png"),
    "ending3_texture": preload("res://Scenes/Labor/assets/ending3.png"),
    "ending4_texture": preload("res://Scenes/Labor/assets/ending4.png"),
    "ending5_texture": preload("res://Scenes/Labor/assets/ending5.png"),
    "ending6_texture": preload("res://Scenes/Labor/assets/ending6.png"),
    "ending7_texture": preload("res://Scenes/Labor/assets/ending7.png"),
    "ending8_texture": preload("res://Scenes/Labor/assets/ending8.png")
}

func get_ending_number() -> int:
    var has_bloody_head = Globals.inventory.has("HeadBloody")
    var has_bloody_hands = Globals.inventory.has("HandsBloody") 
    var has_bloody_leg = Globals.inventory.has("LegBloody")
    
    # Convert to bad/good status based on bloody state
    var bad_head = has_bloody_head
    var bad_hand = has_bloody_hands
    var bad_leg = has_bloody_leg
    
    # Check against the matrix conditions
    if bad_head && bad_hand && bad_leg:
        return 1
    elif bad_head && !bad_hand && bad_leg:
        return 2
    elif bad_head && bad_hand && !bad_leg:
        return 3
    elif bad_head && !bad_hand && !bad_leg:
        return 4
    elif !bad_head && !bad_hand && !bad_leg:
        return 5
    elif !bad_head && !bad_hand && bad_leg:
        return 6
    elif !bad_head && bad_hand && !bad_leg:
        return 7
    elif !bad_head && bad_hand && bad_leg:
        return 8
    
    return 1  # Default fallback
    
func set_appropriate_ending_texture() -> void:
    var ending_number = get_ending_number()
    var texture_key = "ending" + str(ending_number) + "_texture"
    ending_photo.texture = ending_textures[texture_key]
    
func _ready() -> void:
    show_photo()
func show_photo() -> void:
    # Make sure all nodes are visible
    ending_photo.show()
    ok_button.show()
    photo_background.show()
    label.show()
    
    set_appropriate_ending_texture()
    Globals.current_objective = ""
    Globals.player_movement_blocked = true
    
    # Set initial transparency for all elements
    ending_photo.modulate = Color(1, 1, 1, 0)
    ok_button.modulate = Color(1, 1, 1, 0)
    photo_background.modulate = Color(1, 1, 1, 0)
    label.modulate = Color(1, 1, 1, 0)
    ok_button.disabled = true
    
    # Setup flash overlay
    flash_overlay.color = Color(1, 1, 1, 0)
    flash_overlay.show()
    
    # Create flash effect tween
    var flash_tween = create_tween()
    flash_tween.tween_property(flash_overlay, "color", Color(1, 1, 1, 1), flash_in_duration)
    flash_tween.tween_interval(flash_hold_duration)
    flash_tween.tween_property(flash_overlay, "color", Color(1, 1, 1, 0), flash_out_duration)
    
    flash_tween.tween_callback(func(): _show_photo_elements())

func _show_photo_elements() -> void:
    var tween = create_tween()
    tween.parallel().tween_property(photo_background, "modulate", Color(1, 1, 1, 1), ui_fade_duration)
    tween.parallel().tween_property(ending_photo, "modulate", Color(1, 1, 1, 1), photo_fade_duration)
    tween.parallel().tween_property(label, "modulate", Color(1, 1, 1, 1), ui_fade_duration)
    tween.parallel().tween_property(ok_button, "modulate", Color(1, 1, 1, 1), ui_fade_duration)
    
    var timer = get_tree().create_timer(button_enable_delay)
    timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
    ok_button.disabled = false
    flash_overlay.visible = false
    
func _on_ok_button_pressed() -> void:
    print("END GAME HERE YEE")
    ScreenManager.change_screen("res://Scenes/Screens/Menu/menu.tscn")
