extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://SettingsData.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "up", "W")
		config.set_value("keybinding", "alt_jump", "Space")
		config.set_value("keybinding", "left", "A")
		config.set_value("keybinding", "right", "D")
		config.set_value("keybinding", "down", "Mouse Button 2")
		config.set_value("keybinding", "pickThrow", "Mouse Button 1")
		config.set_value("keybinding", "restart", "U")
		
		config.set_value("display", "window_mode", 0)
		
		config.set_value("audio", "master_volume", 0.5)
		config.set_value("audio", "sfx_volume", 1.0)
		config.set_value("audio", "music_volume", 1.0)
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
		
func save_display_settings(key: String, index):
	config.set_value("display", key, index)
	config.save(SETTINGS_FILE_PATH)
	
func load_display_settings():
	var display_settings = {}
	for key in config.get_section_keys("display"):
		display_settings[key] = config.get_value("display", key)
	return display_settings

func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func save_keybinding(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.keycode)
	elif event is InputEventMouseButton:
		event_str = "%s" % "Mouse Button " + str(event.button_index)
	
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)


func load_keybindings():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinding", key)

		if event_str.contains("Mouse Button"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split(" ")[2])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybindings[key] = input_event
	return keybindings
