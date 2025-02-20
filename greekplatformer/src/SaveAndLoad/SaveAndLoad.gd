extends Node

const GAME_SAVE : String = "user://GameSave.json"

var game_save_path : String
var game_save_room : String
var artefact_counter : int
var flag_status : bool

func _ready() -> void:
	SignalBus.on_quit_pressed.connect(on_game_save)
	SignalBus.on_artefact_found.connect(on_artefact_found)
	SignalBus.on_new_game_pressed.connect(delete_game_data)

# Game

var game_data_dictionary : Dictionary = {}

func on_artefact_found(artefact : int, flag : bool):
	var file = FileAccess.open(GAME_SAVE, FileAccess.WRITE)
	game_data_dictionary["artefact_counter"] = artefact
	game_data_dictionary["flag"] = flag
	var json = JSON.stringify(game_data_dictionary)
	
	file.store_string(json)
	file.close()

func on_game_save(path : String, room : String, artefact : int, flag : bool):
	var file = FileAccess.open(GAME_SAVE, FileAccess.WRITE)
	game_data_dictionary["path"] = path
	game_data_dictionary["room"] = room
	game_data_dictionary["artefact_counter"] = artefact
	game_data_dictionary["flag"] = flag
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
	artefact_counter = saved_data["artefact_counter"]
	flag_status = saved_data["flag"]
	file.close()

func delete_game_data():
	var file = FileAccess.open(GAME_SAVE, FileAccess.WRITE)
	game_data_dictionary["path"] = ""
	game_data_dictionary["room"] = ""
	game_data_dictionary["artefact_counter"] = 0
	game_data_dictionary["flag"] = true
	var json = JSON.stringify(game_data_dictionary)
	
	file.store_string(json)
	file.close()
