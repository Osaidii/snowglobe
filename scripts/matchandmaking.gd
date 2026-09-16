extends Node2D

const MAP_1 = preload("uid://bymwcyrqq7kgc")
const MAP_2 = preload("uid://dwcbtb74d07bd")
const PLAYER = preload("uid://ct1ysgutbxa0y")

@onready var _3: Node2D = $"MatchMaking/PlayerPoints/3"
@onready var _4: Node2D = $"MatchMaking/PlayerPoints/4"
@onready var _5: Node2D = $"MatchMaking/PlayerPoints/5"
@onready var _6: Node2D = $"MatchMaking/PlayerPoints/6"

@onready var match_making: Node2D = $MatchMaking
@onready var match_node: Node2D = $Match
@onready var start: TextureButton = $MatchMaking/Start
@onready var back: TextureButton = $MatchMaking/Back
@onready var controls: TextureButton = $MatchMaking/Controls

func _ready() -> void:
	Transition.scene_in()
	start.grab_focus()

func _on_start_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.0).timeout
	instanciate_everything()
	await get_tree().create_timer(0.1).timeout
	Transition.scene_in()
	await get_tree().create_timer(1.0).timeout
	start_match()

func start_match() -> void:
	pass

func instanciate_player(outfit_number, controls_number, id, positon: Vector2):
	var instance  = PLAYER.instantiate()
	instance.ID = id 
	instance.OUTFIT = outfit_number
	instance.CONTROLS = controls_number
	match_node.add_child(instance)
	instance.global_position = positon

func instanciate_everything() -> void:
	var amount_of_players := 2
	if _3.get_child(1).visible:
		amount_of_players += 1
	if _4.get_child(1).visible:
		amount_of_players += 1
	if _5.get_child(1).visible:
		amount_of_players += 1
	if _6.get_child(1).visible:
		amount_of_players += 1
	var random_array = []
	for i in range(amount_of_players):
		random_array.append(i)
	random_array.shuffle()
	match_making.visible = false
	match_node.visible = true
	instanciate_map(1)
	instanciate_player(1, 1, 1, match_node.get_child(0).get_child(0).get_child(random_array[0]).global_position)
	instanciate_player(2, 2, 2, match_node.get_child(0).get_child(0).get_child(random_array[1]).global_position)
	if _3.get_child(1).visible:
		instanciate_player(3, 3, 3, match_node.get_child(0).get_child(0).get_child(random_array[2]).global_position)
	if _4.get_child(1).visible:
		instanciate_player(4, 4, 4, match_node.get_child(0).get_child(0).get_child(random_array[3]).global_position)
	if _5.get_child(1).visible:
		instanciate_player(5, 5, 5, match_node.get_child(0).get_child(0).get_child(random_array[4]).global_position)
	if _6.get_child(1).visible:
		instanciate_player(6, 6, 6, match_node.get_child(0).get_child(0).get_child(random_array[5]).global_position)

func instanciate_map(map_number):
	var map
	match map_number:
		1:
			map = MAP_1
		2:
			map = MAP_2
	var instance  = map.instantiate()
	match_node.add_child(instance)

func _on_back_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

func match_end():
	Transition.scene_out()
	await get_tree().create_timer(1.0).timeout
	for i in range(match_node.get_child_count()):
		match_node.get_child(i).queue_free()
	match_node.visible = false
	match_making.visible = true
	await get_tree().create_timer(0.5).timeout
	Transition.scene_in()
	start.grab_focus()

func _on_add_3_pressed() -> void:
	_3.get_child(0).visible = true
	_3.get_child(1).visible = true
	_3.get_child(2).visible = false
	_4.get_child(2).visible = true
	_4.get_child(2).grab_focus()
	start.focus_neighbor_top = _4.get_child(2).get_path()
	back.focus_neighbor_top = _4.get_child(2).get_path()
	controls.focus_neighbor_top = _4.get_child(2).get_path()

func _on_add_4_pressed() -> void:
	_4.get_child(0).visible = true
	_4.get_child(1).visible = true
	_4.get_child(2).visible = false
	_5.get_child(2).visible = true
	_5.get_child(2).grab_focus()
	start.focus_neighbor_top = _5.get_child(2).get_path()
	back.focus_neighbor_top = _5.get_child(2).get_path()
	controls.focus_neighbor_top = _5.get_child(2).get_path()

func _on_add_5_pressed() -> void:
	_5.get_child(0).visible = true
	_5.get_child(1).visible = true
	_5.get_child(2).visible = false
	_6.get_child(2).visible = true
	_6.get_child(2).grab_focus()
	start.focus_neighbor_top = _6.get_child(2).get_path()
	back.focus_neighbor_top = _6.get_child(2).get_path()
	controls.focus_neighbor_top = _6.get_child(2).get_path()

func _on_add_6_pressed() -> void:
	_6.get_child(0).visible = true
	_6.get_child(1).visible = true
	_6.get_child(2).visible = false
	start.grab_focus()
