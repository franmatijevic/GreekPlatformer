extends Node

var windows_mode_index : int = 0
var master_volume_value : float = 0
var sfx_volume_value : float = 0
var music_volume_value : float = 0

func _ready() -> void:
	SignalBus.on_window_mode.connect(on_window_mode)
	SignalBus.on_master_volume.connect(on_master_volume)
	SignalBus.on_sfx_volume.connect(on_sfx_volume)
	SignalBus.on_music_volume.connect(on_music_volume)
	
func create_storage_dictionary() -> Dictionary:
	var settings_dict : Dictionary = {
		"windows_mode_index" = windows_mode_index,
		"master_volume_value" = master_volume_value,
		"sfx_volume_value" = sfx_volume_value,
		"music_volume_value" = music_volume_value,
		"up" = InputMap.action_get_events("up")
	}
	
	return settings_dict

func on_window_mode(index : int):
	windows_mode_index = index

func on_master_volume(value : float):
	master_volume_value = value

func on_sfx_volume(value : float):
	sfx_volume_value = value

func on_music_volume(value : float):
	music_volume_value = value
