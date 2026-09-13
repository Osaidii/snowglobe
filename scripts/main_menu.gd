extends Node2D

const MATCHANDMAKING = preload("uid://sdkadgq6g1mq") as PackedScene

@onready var play: Button = $Play
@onready var settings: Button = $Settings
@onready var exit: Button = $Exit
@onready var create: Button = $Create
@onready var join: Button = $Join
@onready var back: TextureButton = $Back

func _on_play_pressed() -> void:
	create.visible = true
	join.visible = true
	back.visible = true
	play.visible = false
	settings.visible = false
	exit.visible = false

func _on_back_pressed() -> void:
	create.visible = false
	join.visible = false
	back.visible = false
	play.visible = true
	settings.visible = true
	exit.visible = true

func _on_create_pressed() -> void:
	get_tree().change_scene_to_packed(MATCHANDMAKING)

func _on_exit_pressed() -> void:
	get_tree().quit()
