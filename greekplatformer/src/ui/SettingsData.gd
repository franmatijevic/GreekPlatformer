extends Node

const DEFAULT_WINDOWS_MODE_INDEX : int = 0
const DEFAULT_MASTER_VOLUME_VALUE : float = 0.5
const DEFAULT_SFX_VOLUME_VALUE : float = 1
const DEFAULT_MUSIC_VOLUME_VALUE : float = 1

var windows_mode_index : int = 0
var master_volume_value : float = 0
var sfx_volume_value : float = 0
var music_volume_value : float = 0

var loaded_data : Dictionary = {}

func _ready() -> void:
	SignalBus.on_window_mode.connect(on_window_mode)
	SignalBus.on_master_volume.connect(on_master_volume)
	SignalBus.on_sfx_volume.connect(on_sfx_volume)
	SignalBus.on_music_volume.connect(on_music_volume)
	SignalBus.load_settings_data.connect(on_settings_data_loaded)
	
func create_storage_dictionary() -> Dictionary:
	var settings_dict : Dictionary = {
		"windows_mode_index" = windows_mode_index,
		"master_volume_value" = master_volume_value,
		"sfx_volume_value" = sfx_volume_value,
		"music_volume_value" = music_volume_value,
	}
	
	return settings_dict

func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_WINDOWS_MODE_INDEX
	return windows_mode_index
	
func get_master_volume_value() -> float:
	if loaded_data == {}:
		return DEFAULT_MASTER_VOLUME_VALUE
	return master_volume_value
	
func get_sfx_volume_value() -> float:
	if loaded_data == {}:
		return DEFAULT_SFX_VOLUME_VALUE
	return sfx_volume_value

func get_music_volume_value() -> float:
	if loaded_data == {}:
		return DEFAULT_MUSIC_VOLUME_VALUE
	return music_volume_value

func on_window_mode(index : int):
	windows_mode_index = index

func on_master_volume(value : float):
	master_volume_value = value

func on_sfx_volume(value : float):
	sfx_volume_value = value

func on_music_volume(value : float):
	music_volume_value = value

func on_settings_data_loaded(data : Dictionary):
	loaded_data = data
	on_window_mode(loaded_data.windows_mode_index)
	on_master_volume(loaded_data.master_volume_value)
	on_sfx_volume(loaded_data.sfx_volume_value)
	on_music_volume(loaded_data.music_volume_value)
