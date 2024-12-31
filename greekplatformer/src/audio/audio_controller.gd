extends Node2D

@export var mute: bool = false
@export_range (0,1) var SFXvolume:float=0.75
@export_range (0,1) var Musicvolume:float=0.75

var rng = RandomNumberGenerator.new()
var death_number: int

func _ready():
	death_number = rng.randi_range(0, 1)

func play_sound(audio:AudioStreamPlayer, pitchVariance:bool):
	if mute or SFXvolume==0:
		return
	
	if(pitchVariance):
		var pitch = randf_range(0.95, 1.05)
		audio.pitch_scale=pitch
	
	audio.play()

func update_volume():
	var sfx_index= AudioServer.get_bus_index("SFX")
	var value_in_db=SFXvolume
	AudioServer.set_bus_volume_db(sfx_index, value_in_db)

func play_breaking_platform():
	play_sound($SFX/breaking_platform,1)

func play_cloud():
	play_sound($SFX/cloud,1)

func play_death():
	if death_number:
		play_sound($SFX/death1,0)
	else:
		play_sound($SFX/death2,0)

func play_door_opening():
	play_sound($SFX/door_opening,0)

func play_lever():
	play_sound($SFX/lever,0)

func play_seagull():
	play_sound($SFX/seagull,1)

func play_stone_fall():
	play_sound($SFX/stone_fall,1)

func play_walk_ceramic():
	play_sound($SFX/walk_ceramic,0)

func play_spring():
	play_sound($SFX/spring,1)

func play_ground_stomp():
	play_sound($SFX/stone_fall,1)
