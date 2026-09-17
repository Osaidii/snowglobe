extends Node2D

const MATCHANDMAKING = preload("uid://sdkadgq6g1mq") as PackedScene

@onready var play: TextureButton = $Play
@onready var settings: TextureButton = $Settings
@onready var exit: TextureButton = $Exit
@onready var create: TextureButton = $Create
@onready var join: TextureButton = $Join
@onready var back: TextureButton = $Back
@onready var anims: AnimationPlayer = $Anims

# This function sets up the scene.
func _ready() -> void:
	Transition.scene_in()
	play.grab_focus()

# This function runs when play is pressed.
func _on_play_pressed() -> void:
	anims.play("play")
	create.grab_focus()

# This function runs when back is pressed.
func _on_back_pressed() -> void:
	anims.play("back")
	play.grab_focus()

# This function runs when create is pressed.
func _on_create_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.3).timeout
	get_tree().change_scene_to_packed(MATCHANDMAKING)

# This function runs when exit is pressed.
func _on_exit_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.3).timeout
	get_tree().quit()

# This function runs when settings is pressed.
func _on_settings_pressed() -> void:
	anims.play("settings error")

# This function runs when join is pressed.
func _on_join_pressed() -> void:
	anims.play("join error")
