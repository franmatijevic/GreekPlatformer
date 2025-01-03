extends Node

signal display_dialogue(text_key)
signal dialogue_finished

signal npc_enter
signal npc_exit
signal perform_action(action, params)


# Settings

signal on_window_mode(index : int)
signal on_master_volume(value : float)
signal on_sfx_volume(value : float)
signal on_music_volume(value : float)

signal set_settings_dictionary(settings_dictionary : Dictionary)

func emit_set_settings_dictionary(settings_dictionary : Dictionary):
	set_settings_dictionary.emit(settings_dictionary)

func emit_on_window_mode(index : int):
	on_window_mode.emit(index)
	
func emit_on_master_volume(value : float):
	on_master_volume.emit(value)
	
func emit_on_sfx_volume(value : float):
	on_sfx_volume.emit(value)
	
func emit_on_music_volume(value : float):
	on_music_volume.emit(value)
