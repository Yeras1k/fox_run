extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}
var restart_data = {
	"scene": ["res://scenes/Game/Game.tscn"],
	"is_two": false,
	"position": [[77, 223], [77, 223]],
	"enemy_position": [[340, 170], [156, 73]],
	"coins": 0,
	"enemy_is_dead": []
}

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
func restart():
	var file = File.new()
	game_data = {
		"scene": ["res://scenes/Game/Game.tscn"],
		"is_two": false,
		"position": [[77, 223], [77, 223]],
		"coins": 0,
		"enemy_is_dead": [],
		"is_coin": []
	}
	save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"scene": ["res://scenes/Game/Game.tscn"],
			"is_two": false,
			"position": [[77, 223], [77, 223]],
			"coins": 0,
			"enemy_is_dead": [],
			"is_coin": []
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	
	

