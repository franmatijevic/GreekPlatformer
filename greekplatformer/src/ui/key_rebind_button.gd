extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button


@export var action_name : String = ""

var is_remapping = false

func _ready():
	set_process_unhandled_input(false)
	set_action_name()
	set_text_for_key()
	load_keybindings_from_settings()
	
func load_keybindings_from_settings():
	var keybindings = ConfigFileHandler.load_keybindings()
	
	var action_event = keybindings[action_name]
	
	if action_event is InputEventKey:
		var action_keycode = OS.get_keycode_string(action_event.keycode)
		button.text = "%s" % action_keycode
	elif action_event is InputEventMouseButton:
		var action_keycode = OS.get_keycode_string(action_event.button_index)
		button.text = "%s" % "Mouse Button " + str(action_event.button_index)
		
	rebind_action_key_initial(action_event)

func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"up":
			label.text = "Jump"
		"alt_jump":
			label.text = "Alt Jump"
		"down":
			label.text = "Drop item"
		"left":
			label.text = "Move left"
		"right":
			label.text = "Move right"
		"pickThrow":
			label.text = "Interact"
		"restart":
			label.text = "Restart"
			
			
func set_text_for_key():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	
	if action_event is InputEventKey:
		var action_keycode = OS.get_keycode_string(action_event.keycode)
		button.text = "%s" % action_keycode
	elif action_event is InputEventMouseButton:
		var action_keycode = OS.get_keycode_string(action_event.button_index)
		button.text = "%s" % "Mouse Button " + str(action_event.button_index)
		
	button.pressed.connect(_on_input_button_pressed.bind(button, action_event))


func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		button.text = "Select a key"


func _input(event: InputEvent) -> void:
	if is_remapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.pressed)):
			rebind_action_key(event)
			is_remapping = false
			accept_event()


func rebind_action_key(event):
	var is_duplicate = false
	var action_event = event
	var action_keycode
	
	if action_event is InputEventMouseButton:
		action_keycode = OS.get_keycode_string(action_event.button_index)
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				if (i.button.text == "%s" % "Mouse Button " + str(action_event.button_index)):
					is_duplicate = true
					set_text_for_key()
					break
	elif action_event is InputEventKey:
		action_keycode = OS.get_keycode_string(action_event.keycode)
		if (action_keycode == "Escape"):
			is_duplicate = true
			set_text_for_key()
		else:
			for i in get_tree().get_nodes_in_group("hotkey_button"):
				if i.action_name != self.action_name:
					if (i.button.text == "%s" % action_keycode):
						is_duplicate = true
						set_text_for_key()
						break

	if not is_duplicate:
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)

		ConfigFileHandler.save_keybinding(action_name, event)
		
		set_text_for_key()
		set_action_name()
		

func rebind_action_key_initial(event):
	var action_event = event
	var action_keycode
	
	if action_event is InputEventMouseButton:
		action_keycode = OS.get_keycode_string(action_event.button_index)
	elif action_event is InputEventKey:
		action_keycode = OS.get_keycode_string(action_event.keycode)
		
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)

	ConfigFileHandler.save_keybinding(action_name, event)
		
	set_text_for_key()
	set_action_name()
