extends Node2D

@export var mute: bool = false
@export_range (0,1) var SFXvolume:float=0.75
@export_range (0,1) var Musicvolume:float=0.75

var rng = RandomNumberGenerator.new()

func play_sound(audio:AudioStreamPlayer, pitchVariance:bool, fromPoint:float):
	if mute or SFXvolume==0:
		return
	
	if(pitchVariance):
		var pitch = randf_range(0.95, 1.05)
		audio.pitch_scale=pitch
	
	audio.play(fromPoint)

func play_sound_stackable(audio_stream:AudioStream, pitchVariance:bool, fromPoint:float):
	if mute or SFXvolume==0:
		return
	
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	audio_player.stream = audio_stream
	if(pitchVariance):
		var pitch = randf_range(0.95, 1.05)
		audio_player.pitch_scale=pitch
	
	audio_player.connect("finished", Callable(audio_player, "queue_free"))
	
	audio_player.play(fromPoint)

func stop_sound(audio:AudioStreamPlayer):
	audio.stop()

func positionSound(audio:AudioStreamPlayer2D, pitchVariance:bool):
	if mute or SFXvolume==0:
		return
	
	if(pitchVariance):
		var pitch = randf_range(0.95, 1.05)
		audio.pitch_scale=pitch
	
	audio.play(audio.position.x)


#func update_volume():
#	var sfx_index= AudioServer.get_bus_index("SFX")
#	var value_in_db=SFXvolume
#	AudioServer.set_bus_volume_db(sfx_index, value_in_db)

func play_breaking_platform():
	play_sound_stackable($SFX/breaking_platform.stream,1,0)

func play_cloud():
	play_sound_stackable($SFX/cloud.stream,1,0)

func play_thunder():
	play_sound_stackable($SFX/thunder.stream, 1, 0)

func play_death():
	match rng.randi_range(0, 1):
		0:
			play_sound($SFX/death1,0,0)
		1:
			play_sound($SFX/death2,0,0)

func play_door_opening():
	play_sound($SFX/door_opening,0,rng.randi_range(0, 20))

func stop_door_opening():
	stop_sound($SFX/door_opening)

func play_lever():
	play_sound($SFX/lever,0,0)
	
func play_bat():
	play_sound_stackable($SFX/bat.stream, 1, 0)

func play_seagull():
	match rng.randi_range(0, 5):
		0:
			play_sound($SFX/pidgeon1,1,0)
		1:
			play_sound($SFX/pidgeon2,1,0)
		2:
			play_sound($SFX/pidgeon3,1,0)
		3:
			play_sound($SFX/pidgeon4,1,0)
		4:
			play_sound($SFX/pidgeon5,1,0)
		5:
			play_sound($SFX/pidgeon6,1,0)
	
	#play_sound($SFX/seagull,1)

func play_stone_fall():
	play_sound($SFX/stone_fall,1,0)

func play_walk_ceramic():
	play_sound($SFX/walk_ceramic,0,0)

func play_spring():
	play_sound_stackable($SFX/spring.stream,1,0)

func play_ground_stomp():
	play_sound($SFX/stone_fall,1,0)

func play_jump():
	match rng.randi_range(0, 3):
		0:
			play_sound($SFX/jump1,1.0,0)
		1:
			play_sound($SFX/jump2,1.0,0)
		2:
			play_sound($SFX/jump3, 1.0,0)
		3:
			play_sound($SFX/jump4, 1.0,0)

func play_zeus_grunt():
	match rng.randi_range(0, 1):
		0:
			play_sound($SFX/zeus_grunt_1,1.0,0)
		1:
			play_sound($SFX/zeus_grunt_2,1.0,0)

func play_dialogue(activeSpeaker: String):
	match activeSpeaker:
		"Prometej":
			play_sound($SFX/talk_prometej, 0, rng.randi_range(0, 6))
		"Zeus":
			play_sound($SFX/talk_zeus, 0, rng.randi_range(0, 6))
		"Atena":
			play_sound($SFX/talk_atena, 0, rng.randi_range(0, 6))
		"npc_musko":
			play_sound($SFX/talk_npc_musko, 0, rng.randi_range(0, 6))
		"npc_zensko":
			play_sound($SFX/talk_npc_zensko, 0, rng.randi_range(0, 6))
		"Atena2":
			play_sound($SFX/talk_atena, 0, rng.randi_range(0, 6))
		"npc_man":
			play_sound($SFX/talk_npc_musko, 0, rng.randi_range(0, 6))
		"npc_woman":
			play_sound($SFX/talk_npc_zensko, 0, rng.randi_range(0, 6))

func stop_dialogue(activeSpeaker: String):
	match activeSpeaker:
		"Prometej":
			stop_sound($SFX/talk_prometej)
		"Zeus":
			stop_sound($SFX/talk_zeus)
		"Atena":
			stop_sound($SFX/talk_atena)
		"npc_musko":
			stop_sound($SFX/talk_npc_musko)
		"npc_zensko":
			stop_sound($SFX/talk_npc_zensko)
		"Atena2":
			stop_sound($SFX/talk_atena)
		"npc_man":
			stop_sound($SFX/talk_npc_musko)
		"npc_woman":
			stop_sound($SFX/talk_npc_zensko)
			
func play_menu_music():
	play_sound($Music/TimpaniMenu, 0, 0)

func play_game_music():
	if $Music/AmforaMaster.is_playing():
		return
	play_sound($Music/AmforaMaster, 0, 0)

func play_boss_music():
	play_sound($Music/BossMusic, 0, 0)

func stop_menu_music():
	stop_sound($Music/TimpaniMenu)

func stop_game_music():
	stop_sound($Music/AmforaMaster)

func stop_boss_music():
	stop_sound($Music/BossMusic)

func playerHitGround():
	play_sound($SFX/PlayerLand, 1, 0)

func stop_walk():
	stop_sound($SFX/walk_ceramic)

func stop_all_music():
	AudioController.stop_menu_music()
	AudioController.stop_game_music()
	AudioController.stop_boss_music()
