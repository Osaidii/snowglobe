extends Node

var current_music_number := 0

# This function starts the loop of music playing.
func _ready() -> void:
	get_child(0).playing = true

# This function changes the music everytime one music ends.
func _on_music_finished() -> void:
	current_music_number += 1
	if current_music_number >= get_child_count():
		current_music_number = 0
	await get_tree().create_timer(5.0).timeout
	get_child(current_music_number).playing = true
