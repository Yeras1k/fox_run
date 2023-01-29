extends Node2D

onready var game_data = SaveFile.game_data
onready var restart_data = SaveFile.restart_data
var selected_menu = 0
func change_menu_color():
	$NewGame.color = Color(0, 0, 0, 0)
	$LoadGame.color = Color(0, 0, 0, 0)
	$Quit.color = Color(0, 0, 0, 0)
	match selected_menu:
		0:
			$NewGame.color = Color("ff9002")
		1:
			$LoadGame.color = Color("ff9002")
		2:
			$Quit.color = Color("ff9002")

func _ready():
	change_menu_color()

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 2
		change_menu_color()
	elif Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				SaveFile.restart()
				get_tree().change_scene("res://scenes/Game/Game.tscn")
			1:
				get_tree().change_scene(game_data.scene)
			2:
				# Quit game
				get_tree().quit()
