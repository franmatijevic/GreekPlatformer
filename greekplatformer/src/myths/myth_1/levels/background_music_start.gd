extends Node

@export var menuMusic: bool
@export var backgroundMusic: bool
@export var bossMusic: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if menuMusic == true:
		AudioController.play_menu_music()
		AudioController.stop_game_music()
		AudioController.stop_boss_music()
	
	if backgroundMusic:
		AudioController.play_game_music()
		AudioController.stop_menu_music()
		AudioController.stop_boss_music()
	
	if bossMusic:
		AudioController.play_boss_music()
		AudioController.stop_game_music()
		AudioController.stop_menu_music()
