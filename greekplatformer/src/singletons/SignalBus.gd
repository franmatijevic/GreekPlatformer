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
signal on_changed_room(path : String, room : String)
signal on_quit_pressed(path : String, room : String)
signal on_new_game_pressed()

signal set_settings_dictionary(settings_dictionary : Dictionary)

signal load_settings_data(settings_dictionary : Dictionary)

func emit_on_new_game_pressed():
	on_new_game_pressed.emit()

func emit_on_changed_room(path : String, room : String):
	on_changed_room.emit(path, room)
	
func emit_on_quit_pressed(path: String, room : String):
	on_quit_pressed.emit(path, room)

func emit_load_settings_data(settings_dictionary : Dictionary):
	load_settings_data.emit(settings_dictionary)

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
