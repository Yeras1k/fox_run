extends Node2D

onready var player2 = "%player2"
onready var player = "%player"
onready var game_data = SaveFile.game_data
onready var _pm = $"%PopupMenu"
enum PopUpID {
	RESUME,
	MAIN_MENU,
	SECOND_PLAYER
}

func _ready():
	print("dddddddd")
	_pm.add_item('RESUME', PopUpID.RESUME)
	_pm.add_item('MAIN MENU(with SAVE)', PopUpID.MAIN_MENU)
	_pm.add_item('2 Players', PopUpID.SECOND_PLAYER)
	_pm.connect("id_pressed", self, "_on_PopupMenu_id_pressed")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_pm.popup(Rect2(175, 107, 230, 100))
	if Input.is_action_pressed("ui_cancel"):
		_pm.popup(Rect2(50, 50, 0, 0))

func _on_PopupMenu_id_pressed(id):
	if id == 0:
		hide()
	if id == 1:
		game_data.position[0] = [get_parent().get_node("player").position.x, get_parent().get_node("player").position.y]
		if game_data.is_two:
			game_data.position[1] = [get_parent().get_node("%player2").position.x, get_parent().get_node("%player2").position.y]
		game_data.scene = get_tree().current_scene.filename
		print(game_data.scene)
		get_tree().change_scene("res://scenes/StartScene/StartScreen.tscn")
		get_tree().paused = false
	if id == 2:
		print(str(game_data.scene))
		get_parent().second_player()
	else:
		pass

