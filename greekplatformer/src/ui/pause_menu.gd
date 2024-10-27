extends Control

@onready var generic_level_script = $"../.."

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		generic_level_script.pauseMenu()

func _on_resume_pressed() -> void:
	generic_level_script.pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().quit()
