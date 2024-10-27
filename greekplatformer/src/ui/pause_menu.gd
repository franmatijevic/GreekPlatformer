extends Control

@onready var generic_level_script = $"../.."
@onready var canvas_layer_pause: CanvasLayer = $".."

func _ready() -> void:
	generic_level_script.connect("toggle_paused", _on_generic_level_script_toggle_paused)

func _on_generic_level_script_toggle_paused(paused: bool):
	if paused:
		canvas_layer_pause.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		canvas_layer_pause.hide()
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_resume_pressed() -> void:
	generic_level_script.game_paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_restart_pressed() -> void:
	generic_level_script.restart()
	generic_level_script.game_paused = false
