extends Node

const GAME_SAVE : String = "user://GameSave.json"

var game_save_path : String
var game_save_room : String

func _ready() -> void:
	SignalBus.on_quit_pressed.connect(on_game_save)
	SignalBus.on_new_game_pressed.connect(delete_game_data)

# Game

var game_data_dictionary : Dictionary = {}

func on_game_save(path : String, room : String):
	var file = FileAccess.open(GAME_SAVE, FileAccess.WRITE)
	game_data_dictionary["path"] = path
	game_data_dictionary["room"] = room
	var json = JSON.stringify(game_data_dictionary)
	
	file.store_string(json)
	file.close()

func load_game_data():
	if !FileAccess.file_exists(GAME_SAVE):
		return
	
	var file = FileAccess.open(GAME_SAVE, FileAccess.READ)
	var json = file.get_as_text()
	var saved_data = JSON.parse_string(json)
	
	game_save_path = saved_data["path"]
	game_save_room = saved_data["room"]
	file.close()

func delete_game_data():
	var file = FileAccess.open(GAME_SAVE, FileAccess.WRITE)
	game_data_dictionary["path"] = ""
	game_data_dictionary["room"] = ""
	var json = JSON.stringify(game_data_dictionary)
	
	file.store_string(json)
	file.close()
