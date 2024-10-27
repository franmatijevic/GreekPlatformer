extends Node2D

@export var player:Player
@export var current_state:State

var states: Dictionary = {}

var block:bool=false#blokirat ce pauziranje i resetiranje sobe dok traje tranzicija sobe

func _ready():
	global_position=player.global_position
	$Camera2D.reset_smoothing()
	
	for i in get_node("States").get_children():
		states[i.name.to_lower()] = i
	if current_state:
		current_state.enter()

func _physics_process(delta: float) -> void:
	current_state.update_physics_process(delta)

func set_state(state: String):
	current_state.exit()
	current_state = states[state.to_lower()]
	current_state.enter()
