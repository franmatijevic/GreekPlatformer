extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton as OptionButton


const WINDOW_MODE_ARRAY : Array[String] = [
	"Fullscreen",
	"Windowed",
	"Borderless Fullscreen",
	"Borderless Windowed"
]

func _ready() -> void:
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)
	load_data()
	
func load_data():
	on_window_mode_selected(SettingsData.get_window_mode_index())
	option_button.select(SettingsData.get_window_mode_index())
	
func add_window_mode_items():
	for i in WINDOW_MODE_ARRAY:
		option_button.add_item(i)
	
func on_window_mode_selected(index : int):
	SignalBus.emit_on_window_mode(index)
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
