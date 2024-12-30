extends Node2D

@export var mute: bool = false

var rng = RandomNumberGenerator.new()
var death_number: int

func _ready():
	death_number = rng.randi_range(0, 1)

func play_breaking_platform():
	if not mute:
		$SFX/breaking_platform.play()

func play_cloud():
	if not mute:
		$SFX/cloud.play()

func play_death():
	if not mute:
		if death_number:
			$SFX/death1.play()
		else:
			$SFX/death2.play()

func play_door_opening():
	if not mute:
		$SFX/door_opening.play()

func play_lever():
	if not mute:
		$SFX/lever.play()

func play_seagull():
	if not mute:
		$SFX/seagull.play()

func play_stone_fall():
	if not mute:
		$SFX/stone_fall.play()

func play_walk_ceramic():
	if not mute:
		$SFX/walk_ceramic.play()

func play_spring():
	if not mute:
		$SFX/spring.play()
