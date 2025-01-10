extends Node

const SETTINGS_SAVE : String = "user://SettingsData1.json"

# Settings

var settings_data_dictionary : Dictionary = {}

func _ready() -> void:
	SignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()
	
func on_settings_save(data : Dictionary):
	var save_settings_file = FileAccess.open(SETTINGS_SAVE, FileAccess.WRITE)
	var json_data = JSON.stringify(data)
	
	save_settings_file.store_line(json_data)

func load_settings_data():
	if !FileAccess.file_exists(SETTINGS_SAVE):
		return
	
	var save_settings_data_file = FileAccess.open(SETTINGS_SAVE, FileAccess.READ)
	var loaded_data : Dictionary = {}
	
	while save_settings_data_file.get_position() < save_settings_data_file.get_length():
		var json_string = save_settings_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		
		loaded_data = json.get_data()
	
	SignalBus.emit_load_settings_data(loaded_data)
	loaded_data = {}
