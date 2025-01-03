extends Control

@onready var back: Button = $VBoxContainer/Back

signal exit_audio_menu

func _ready() -> void:
	back.button_up.connect(on_back_pressed)
	set_process(false)
	
func on_back_pressed():
	exit_audio_menu.emit()
	SignalBus.emit_set_settings_dictionary(SettingsData.create_storage_dictionary())
	set_process(false)
