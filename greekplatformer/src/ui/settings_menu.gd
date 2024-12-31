extends Control

@onready var back: Button = $VBoxContainer/Back as Button

signal exit_settings_menu

func _ready() -> void:
	back.button_up.connect(on_back_pressed)
	set_process(false)
	
func on_back_pressed():
	exit_settings_menu.emit()
	set_process(false)
