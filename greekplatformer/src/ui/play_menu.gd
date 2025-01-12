extends Control

@onready var new_game: TextureButton = $VBoxContainer/NewGame
@onready var continue_game: TextureButton = $VBoxContainer/ContinueGame as TextureButton
@onready var back: TextureButton = $VBoxContainer/Back as TextureButton


signal exit_play_menu

var new_game_path = "res://src/myths/myth_1/levels/level_1.tscn"

func _ready() -> void:
	new_game.button_up.connect(on_new_game_pressed)
	continue_game.button_up.connect(on_continue_game_pressed)
	back.button_up.connect(on_back_pressed)
	set_process(false)
	
func on_new_game_pressed():
	SceneLoader.load_scene(new_game_path)
	
func on_continue_game_pressed():
	SceneLoader.load_scene(new_game_path)
	
	SceneLoader.continue_from_save(new_game_path, "Scene_3")

func on_back_pressed():
	exit_play_menu.emit()
	set_process(false)
