extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "up", "W")
		config.set_value("keybinding", "alt_jump", "Space")
		config.set_value("keybinding", "left", "A")
		config.set_value("keybinding", "right", "D")
		config.set_value("keybinding", "down", "S")
		config.set_value("keybinding", "pickThrow", "Mouse Button 1")
		config.set_value("keybinding", "restart", "U")
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)


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
