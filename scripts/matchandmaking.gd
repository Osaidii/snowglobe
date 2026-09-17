extends Node2D

const MAP_1 = preload("uid://bymwcyrqq7kgc")
const MAP_2 = preload("uid://dwcbtb74d07bd")
const PLAYER = preload("uid://ct1ysgutbxa0y")

@onready var _3: Node2D = $"MatchMaking/PlayerPoints/3"
@onready var _4: Node2D = $"MatchMaking/PlayerPoints/4"
@onready var _5: Node2D = $"MatchMaking/PlayerPoints/5"
@onready var _6: Node2D = $"MatchMaking/PlayerPoints/6"
@onready var anims: AnimationPlayer = $MatchMaking/Anims
@onready var match_making: Node2D = $MatchMaking
@onready var match_node: Node2D = $Match
@onready var start: TextureButton = $MatchMaking/Start
@onready var back: TextureButton = $MatchMaking/Back
@onready var controls: TextureButton = $MatchMaking/Controls
@onready var death_timer: Timer = $"Death Timer"

var player1: Player
var player2: Player
var player3: Player
var player4: Player
var player5: Player
var player6: Player

var match_running := false
var players_alive := 0
var winner: Player

# This function sets up the scene.
func _ready() -> void:
	Transition.scene_in()
	start.grab_focus()

# This function gives the bomb randomly to another player.
func random_bomb() -> void:
	var temp_array = []
	for i in range(players_alive):
		temp_array.append(i + 1)
	temp_array.shuffle()
	match temp_array[0]:
		1:
			player1.IS_TAGGER = true
		2: 
			player2.IS_TAGGER = true
		3:
			player3.IS_TAGGER = true
		4:
			player4.IS_TAGGER = true
		5:
			player5.IS_TAGGER = true
		6:
			player6.IS_TAGGER = true
	death_timer.start()

func kill_player(player) -> void:
	if player == null:
		return
	player.queue_free()
	players_alive -= 1

# This function does the match instatiation.
func _on_start_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.0).timeout
	instantiate_everything()
	await get_tree().create_timer(0.1).timeout
	Transition.scene_in()
	await get_tree().create_timer(1.0).timeout
	start_match()

func show_winner() -> void:
	death_timer.stop()
	if player1 != null:
		winner = player1
	elif player2 != null:
		winner = player2
	elif player3 != null:
		winner = player3
	elif player4 != null:
		winner = player4
	elif player5 != null:
		winner = player5
	elif player6 != null:
		winner = player6
	# Add showing winne here
	await get_tree().create_timer(10.0).timeout
	Transition.scene_out()
	await get_tree().create_timer(1.3).timeout
	match_end()
	match_making.visible = true
	Transition.scene_in()

# This function starts the match and does the countdown.
func start_match() -> void:
	anims.play("countdown")
	await get_tree().create_timer(3.0).timeout
	player1.CAN_CONTROL = true
	player2.CAN_CONTROL = true
	if player3 != null:
		player3.CAN_CONTROL = true
	if player4 != null:
		player4.CAN_CONTROL = true
	if player5 != null:
		player5.CAN_CONTROL = true
	if player6 != null:
		player6.CAN_CONTROL = true
	match_running = true
	random_bomb()

# This function instatiates player with data provided.
func instantiate_player(outfit_number, controls_number, positon: Vector2):
	var instance  = PLAYER.instantiate()
	instance.OUTFIT = outfit_number
	instance.CONTROLS = controls_number
	match_node.add_child(instance)
	instance.global_position = positon
	return instance

# This function starts to instatiation process.
func instantiate_everything() -> void:
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
	instantiate_map(1)
	player1 = instantiate_player(1, 1, match_node.get_child(0).get_child(0).get_child(random_array[0]).global_position)
	player2 = instantiate_player(2, 2, match_node.get_child(0).get_child(0).get_child(random_array[1]).global_position)
	if _3.get_child(1).visible:
		player3 = instantiate_player(3, 3, match_node.get_child(0).get_child(0).get_child(random_array[2]).global_position)
	if _4.get_child(1).visible:
		player4 = instantiate_player(4, 4, match_node.get_child(0).get_child(0).get_child(random_array[3]).global_position)
	if _5.get_child(1).visible:
		player5 = instantiate_player(5, 5, match_node.get_child(0).get_child(0).get_child(random_array[4]).global_position)
	if _6.get_child(1).visible:
		player6 = instantiate_player(6, 6, match_node.get_child(0).get_child(0).get_child(random_array[5]).global_position)
	players_alive = amount_of_players

# This function instantiaes the selected map.
func instantiate_map(map_number):
	var map
	match map_number:
		1:
			map = MAP_1
		2:
			map = MAP_2
	var instance  = map.instantiate()
	match_node.add_child(instance)

# This function takes the user back to the Main Menu.
func _on_back_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

# This function is the termination and deletion of the match.
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

# This function arranges the UI when a third player is added.
func _on_add_3_pressed() -> void:
	_3.get_child(0).visible = true
	_3.get_child(1).visible = true
	_3.get_child(2).visible = false
	_3.get_child(3).visible = true
	_4.get_child(2).visible = true
	_4.get_child(2).grab_focus()
	start.focus_neighbor_top = _4.get_child(2).get_path()
	back.focus_neighbor_top = _4.get_child(2).get_path()
	controls.focus_neighbor_top = _4.get_child(2).get_path()

# This function arranges the UI when a fourth player is added.
func _on_add_4_pressed() -> void:
	_4.get_child(0).visible = true
	_4.get_child(1).visible = true
	_4.get_child(2).visible = false
	_4.get_child(3).visible = true
	_5.get_child(2).visible = true
	_5.get_child(2).grab_focus()
	_3.get_child(3).focus_neighbor_right = _4.get_child(3).get_path()
	start.focus_neighbor_top = _5.get_child(2).get_path()
	back.focus_neighbor_top = _5.get_child(2).get_path()
	controls.focus_neighbor_top = _5.get_child(2).get_path()

# This function arranges the UI when a fifth player is added.
func _on_add_5_pressed() -> void:
	_5.get_child(0).visible = true
	_5.get_child(1).visible = true
	_5.get_child(2).visible = false
	_5.get_child(3).visible = true
	_6.get_child(2).visible = true
	_6.get_child(2).grab_focus()
	start.focus_neighbor_top = _6.get_child(2).get_path()
	back.focus_neighbor_top = _6.get_child(2).get_path()
	controls.focus_neighbor_top = _6.get_child(2).get_path()

# This function arranges the UI when a sixth player is added.
func _on_add_6_pressed() -> void:
	_6.get_child(0).visible = true
	_6.get_child(1).visible = true
	_6.get_child(2).visible = false
	_6.get_child(3).visible = true
	start.focus_neighbor_top = _4.get_child(3).get_path()
	back.focus_neighbor_top = _5.get_child(3).get_path()
	controls.focus_neighbor_top = _6.get_child(3).get_path()
	_5.get_child(3).focus_neighbor_right = _6.get_child(3).get_path()
	_3.get_child(3).focus_neighbor_bottom = _6.get_child(3).get_path()
	start.grab_focus()

# This function arranges the UI when the third player is removed.
func _on_remove_3_pressed() -> void:
	if _4.get_child(0).visible == true:
		anims.play("remove error")
		return
	_3.get_child(0).visible = false
	_3.get_child(1).visible = false
	_3.get_child(2).visible = true
	_3.get_child(3).visible = false
	_4.get_child(2).visible = false
	_3.get_child(2).grab_focus()
	start.focus_neighbor_top = _3.get_child(2).get_path()
	back.focus_neighbor_top = _3.get_child(2).get_path()
	controls.focus_neighbor_top = _3.get_child(2).get_path()
	_3.get_child(3).focus_neighbor_right = _4.get_child(2).get_path()

# This function arranges the UI when the fourth player is removed.
func _on_remove_4_pressed() -> void:
	if _5.get_child(0).visible == true:
		anims.play("remove error")
		return
	_4.get_child(0).visible = false
	_4.get_child(1).visible = false
	_4.get_child(2).visible = true
	_4.get_child(3).visible = false
	_5.get_child(2).visible = false
	_4.get_child(2).grab_focus()
	start.focus_neighbor_top = _4.get_child(2).get_path()
	back.focus_neighbor_top = _4.get_child(2).get_path()
	controls.focus_neighbor_top = _4.get_child(2).get_path()
	_3.get_child(3).focus_neighbor_right = _4.get_child(2).get_path()

# This function arranges the UI when the fifth player is removed.
func _on_remove_5_pressed() -> void:
	if _6.get_child(0).visible == true:
		anims.play("remove error")
		return
	_5.get_child(0).visible = false
	_5.get_child(1).visible = false
	_5.get_child(2).visible = true
	_5.get_child(3).visible = false
	_6.get_child(2).visible = false
	_5.get_child(2).grab_focus()
	start.focus_neighbor_top = _5.get_child(2).get_path()
	back.focus_neighbor_top = _5.get_child(2).get_path()
	controls.focus_neighbor_top = _5.get_child(2).get_path()
	_4.get_child(3).focus_neighbor_right = _5.get_child(2).get_path()
	_3.get_child(3).focus_neighbor_right = _4.get_child(3).get_path()

# This function arranges the UI when the sixth player is removed.
func _on_remove_6_pressed() -> void:
	_6.get_child(0).visible = false
	_6.get_child(1).visible = false
	_6.get_child(2).visible = true
	_6.get_child(3).visible = false
	_6.get_child(2).grab_focus()
	start.focus_neighbor_top = _6.get_child(2).get_path()
	back.focus_neighbor_top = _6.get_child(2).get_path()
	controls.focus_neighbor_top = _6.get_child(2).get_path()
	_3.get_child(3).focus_neighbor_right = _4.get_child(3).get_path()
	_5.get_child(3).focus_neighbor_bottom = _6.get_child(2).get_path()
	_3.get_child(3).focus_neighbor_bottom = _6.get_child(2).get_path()

func _on_death_timer_timeout() -> void:
	if players_alive <= 1:
		show_winner()
		return
	var player: Player
	if player1.IS_TAGGER and player1 != null:
		player = player1
		player1 = null
	if player2.IS_TAGGER and player2 != null:
		player = player2
		player2 = null
	if player3.IS_TAGGER and player3 != null:
		player = player3
		player3 = null
	if player4.IS_TAGGER and player4 != null:
		player = player4
		player4 = null
	if player5.IS_TAGGER and player5 != null:
		player = player5
		player5 = null
	if player6.IS_TAGGER and player6 != null:
		player = player6
		player6 = null
	kill_player(player)
	random_bomb()
