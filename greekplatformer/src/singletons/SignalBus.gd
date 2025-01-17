extends Node

signal display_dialogue(text_key)
signal dialogue_finished
signal display_full_text

signal can_click_next
signal npc_enter
signal npc_exit
signal perform_action(action, params)

signal on_interacted_artefact

signal on_death

signal on_show_skip_level
signal on_hide_skip_level

func emit_on_interacted_artefact():
	on_interacted_artefact.emit()

func emit_on_death():
	on_death.emit()

func emit_show_skip_level():
	on_show_skip_level.emit()

func emit_hide_skip_level():
	on_hide_skip_level.emit()


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
