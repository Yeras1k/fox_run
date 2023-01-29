extends Node2D

onready var game_data = SaveFile.game_data
onready var player2 = $'%player2'

func _ready():
	print(game_data)
	var coins_arr = game_data.is_coin
	for i in range(coins_arr.size()):
		get_node(coins_arr[i]).visible = false
		get_node(coins_arr[i] + "/CollisionShape2D").disabled = true
	var enemy_arr = game_data.enemy_is_dead
	for i in range(enemy_arr.size()):
		get_node(enemy_arr[i]).hide2()
	if not game_data.is_two:
		print("AAAAAAAAAAAAAAAAAAAAAAAAAA")
		get_node("%player2").visible = game_data.is_two
		get_node("%player/Label").visible = game_data.is_two
	else:
		get_node("%player2").enable()
		
func second_player():
	game_data.is_two = true
	get_node("%player/Label").visible = true
	get_node("%player2").enable()
