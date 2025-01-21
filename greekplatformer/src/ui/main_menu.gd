extends Control

@onready var play: TextureButton = $MarginContainer/HBoxContainer/VBoxContainer/Play as TextureButton
@onready var settings: TextureButton = $MarginContainer/HBoxContainer/VBoxContainer/Settings as TextureButton
@onready var quit: TextureButton = $MarginContainer/HBoxContainer/VBoxContainer/Quit as TextureButton
@onready var settings_menu: Control = $SettingsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer
@onready var play_menu: Control = $PlayMenu


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	AudioController.play_menu_music()
	play.button_up.connect(on_play_pressed)
	settings.button_up.connect(on_settings_pressed)
	quit.button_up.connect(on_quit_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings_menu)
	play_menu.exit_play_menu.connect(on_exit_play_menu)
	
func on_play_pressed():
	$Press.play()
	margin_container.visible = false
	play_menu.set_process(true)
	play_menu.visible = true
	
func on_settings_pressed():
	$Press.play()
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true
	
func on_quit_pressed():
	$Press.play()
	get_tree().quit()
	
func on_exit_settings_menu():
	margin_container.visible = true
	settings_menu.visible = false
	
func on_exit_play_menu():
	margin_container.visible = true
	play_menu.visible = false


func _on_play_mouse_entered() -> void:
	$Hover.play()

func _on_settings_mouse_entered() -> void:
	$Hover.play()

func _on_quit_mouse_entered() -> void:
	$Hover.play()
