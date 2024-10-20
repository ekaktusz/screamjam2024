extends CanvasLayer

func _process(delta):
	# Check animation playback position and adjust volume accordingly
	if $AnimationPlayer.is_playing():
		var animation_position = $AnimationPlayer.current_animation_position
		var max_animation_length = $AnimationPlayer.current_animation_length
	pass
	
func change_screen(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
