extends Node

signal display_dialogue(text_key)
signal dialogue_finished
signal display_full_text

signal can_click_next
signal npc_enter
signal npc_exit
signal perform_action(action, params)


# Settings

signal on_changed_room(path : String, room : String)
signal on_quit_pressed(path : String, room : String)
signal on_new_game_pressed()

func emit_on_new_game_pressed():
	on_new_game_pressed.emit()

func emit_on_changed_room(path : String, room : String):
	on_changed_room.emit(path, room)
	
func emit_on_quit_pressed(path: String, room : String):
	on_quit_pressed.emit(path, room)
