extends Node2D

const MAP_1 = preload("uid://bymwcyrqq7kgc")
const MAP_2 = preload("uid://dwcbtb74d07bd")
const PLAYER = preload("uid://ct1ysgutbxa0y")

@onready var match_making: Node2D = $MatchMaking
@onready var match_node: Node2D = $Match

func _on_start_pressed() -> void:
	match_making.visible = false
	match_node.visible = true
	instanciate_map(1)
	await get_tree().create_timer(0.1).timeout
	#instanciate_player(4, 1, 1)
	instanciate_player(3, 2, 2)

func instanciate_player(outfit_number, controls_number, id):
	var instance  = PLAYER.instantiate()
	instance.ID = id 
	instance.OUTFIT = outfit_number
	instance.CONTROLS = controls_number
	match_node.add_child(instance)
	instance.global_position = Vector2(-70, 60)
	instance.velocity = Vector2(0, 0)

func instanciate_map(map_number):
	var map
	match map_number:
		1:
			map = MAP_1
		2:
			map = MAP_2
	var instance  = map.instantiate()
	match_node.add_child(instance)
