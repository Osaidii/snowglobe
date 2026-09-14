extends Node2D

const MATCHANDMAKING = preload("uid://sdkadgq6g1mq") as PackedScene

@onready var play: TextureButton = $Play
@onready var settings: TextureButton = $Settings
@onready var exit: TextureButton = $Exit
@onready var create: TextureButton = $Create
@onready var join: TextureButton = $Join
@onready var back: TextureButton = $Back
@onready var anims: AnimationPlayer = $Anims

func _on_play_pressed() -> void:
	anims.play("play")

func _on_back_pressed() -> void:
	anims.play("back")

func _on_create_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.3).timeout
	get_tree().change_scene_to_packed(MATCHANDMAKING)

func _on_exit_pressed() -> void:
	get_tree().quit()
