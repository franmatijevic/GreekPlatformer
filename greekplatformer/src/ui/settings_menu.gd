extends Control

@onready var back: Button = $VBoxContainer/Back as Button
@onready var audio_menu: Control = $AudioMenu
@onready var keyboard_config_menu: Control = $KeyboardConfigMenu
@onready var audio: Button = $VBoxContainer/Audio
@onready var keyboard_config: Button = $VBoxContainer/KeyboardConfig
@onready var display: Button = $VBoxContainer/Display
@onready var display_menu: Control = $DisplayMenu


@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var v_box_container_pause_menu: VBoxContainer = $"../VBoxContainer"


signal exit_settings_menu

func _ready() -> void:
	back.button_up.connect(on_back_pressed)
	audio.button_up.connect(on_audio_pressed)
	keyboard_config.button_up.connect(on_keyboard_config_pressed)
	display.button_up.connect(on_display_pressed)
	audio_menu.exit_audio_menu.connect(on_exit_audio_menu)
	keyboard_config_menu.exit_keyboard_config_menu.connect(on_exit_keyboard_config_menu)
	display_menu.exit_display_menu.connect(on_exit_display_menu)
	set_process(false)
	
func on_back_pressed():
	print(get_parent().get_parent().name)
	if get_parent().get_parent().name == "PauseMenu":
		visible = false
		v_box_container_pause_menu.visible = true
	else:
		exit_settings_menu.emit()
		set_process(false)
	
func on_audio_pressed():
	v_box_container.visible = false
	audio_menu.set_process(true)
	audio_menu.visible = true

func on_keyboard_config_pressed():
	v_box_container.visible = false
	keyboard_config_menu.set_process(true)
	keyboard_config_menu.visible = true
	
func on_display_pressed():
	v_box_container.visible = false
	display_menu.set_process(true)
	display_menu.visible = true
	
func on_exit_audio_menu():
	v_box_container.visible = true
	audio_menu.visible = false
	
func on_exit_keyboard_config_menu():
	v_box_container.visible = true
	keyboard_config_menu.visible = false
	
func on_exit_display_menu():
	v_box_container.visible = true
	display_menu.visible = false
