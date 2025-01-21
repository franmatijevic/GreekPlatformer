extends Control

const GAME_SAVE : String = "user://GameSave.json"

@onready var new_game: TextureButton = $VBoxContainer/NewGame
@onready var continue_game: TextureButton = $VBoxContainer/ContinueGame as TextureButton
@onready var back: TextureButton = $VBoxContainer/Back as TextureButton


signal exit_play_menu

var new_game_path = "res://src/myths/myth_1/intro.tscn"
var continue_game_path : String
var continue_game_room : String

func _ready() -> void:
	display_continue_button()
	new_game.button_up.connect(on_new_game_pressed)
	continue_game.button_up.connect(on_continue_game_pressed)
	back.button_up.connect(on_back_pressed)
	set_process(false)
	
func on_new_game_pressed():
	#SceneLoader.load_scene(new_game_path)
	SceneLoader.load_more_level(new_game_path)
	get_parent().get_node("Press").play()

func on_continue_game_pressed():
	SceneLoader.continue_from_save(continue_game_path, continue_game_room)
	get_parent().get_node("Press").play()
	
func on_back_pressed():
	get_parent().get_node("Press").play()
	exit_play_menu.emit()
	set_process(false)

func display_continue_button():
	if (FileAccess.file_exists(GAME_SAVE)):
		var file = FileAccess.open(GAME_SAVE, FileAccess.READ)
		var json = file.get_as_text()
		var saved_data = JSON.parse_string(json)
		
		continue_game_path = saved_data["path"]
		continue_game_room = saved_data["room"]
		file.close()
		
		if (continue_game_path == "" || continue_game_room == ""):
			continue_game.visible = false
	else:
		continue_game.visible = false


func _on_new_game_mouse_entered() -> void:
	get_parent().get_node("Hover").play()


func _on_continue_game_mouse_entered() -> void:
	get_parent().get_node("Hover").play()


func _on_back_mouse_entered() -> void:
	get_parent().get_node("Hover").play()
