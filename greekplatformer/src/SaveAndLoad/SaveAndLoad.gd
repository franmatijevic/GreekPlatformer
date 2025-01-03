extends Node

const SETTINGS_SAVE : String = "user://SettingsData.json"

# Settings

var settings_data_dictionary : Dictionary = {}

func _ready() -> void:
	SignalBus.set_settings_dictionary.connect(on_settings_save)
	
func on_settings_save(data : Dictionary):
	var save_settings_file = FileAccess.open(SETTINGS_SAVE, FileAccess.WRITE)
	var json = JSON.stringify(data)
	
	save_settings_file.store_line(json)
	save_settings_file.close()
