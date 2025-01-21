extends Node

@export var menuMusic: bool
@export var backgroundMusic: bool
@export var bossMusic: bool

@export var reverb:bool=false
@export var chorus:bool=false

# Called when the node enters the scene tree for the first time.
func _ready():
	if menuMusic:
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
	
	#var effect = AudioServer.get_bus_effect(2,1)
	if reverb:
		AudioServer.set_bus_effect_enabled(2, 1, true)
		#effect.hipass=0#.45
	else:
		#effect.hipass=1
		AudioServer.set_bus_effect_enabled(2, 1, false)
	
	
	if chorus:
		AudioServer.set_bus_effect_enabled(2, 2, true)
	else:
		AudioServer.set_bus_effect_enabled(2, 2, false)
