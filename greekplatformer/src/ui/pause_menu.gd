extends Control

@onready var generic_level_script = $"../.."
@onready var canvas_layer_pause: CanvasLayer = $".."
@onready var settings_pause_menu: Control = $Panel/SettingsPauseMenu
@onready var v_box_container: VBoxContainer = $Panel/VBoxContainer
@onready var skip: Button = $Panel/VBoxContainer/Skip

var current_path : String
var current_room : String
var current_artefact : int
var current_flag : bool

func _ready() -> void:
	SignalBus.on_changed_room.connect(on_changed_room)
	SignalBus.on_show_skip_level.connect(show_skip_level)
	SignalBus.on_hide_skip_level.connect(hide_skip_level)
	generic_level_script.connect("toggle_paused", _on_generic_level_script_toggle_paused)

func _on_generic_level_script_toggle_paused(paused: bool):
	if paused:
		canvas_layer_pause.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		AudioServer.set_bus_effect_enabled(2, 0, true)
	else:
		canvas_layer_pause.hide()
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		AudioServer.set_bus_effect_enabled(2, 0, false)

func _on_resume_pressed() -> void:
	generic_level_script.game_paused = false

func _on_quit_pressed() -> void:
	SignalBus.emit_on_quit_pressed(current_path, current_room, current_artefact, current_flag)
	get_tree().quit()

func _on_restart_pressed() -> void:
	AudioController.stop_door_opening()
	generic_level_script.restart()
	generic_level_script.game_paused = false

func _on_settings_pressed() -> void:
	settings_pause_menu.visible = true
	v_box_container.visible = false

func on_changed_room(path : String, room : String, artefact : int, flag : bool):
	current_path = path
	current_room = room
	current_artefact = artefact
	current_flag = flag

func show_skip_level():
	skip.visible = true

func hide_skip_level():
	skip.visible = false


func _on_skip_pressed() -> void:
	generic_level_script.skip()
	_on_restart_pressed()
