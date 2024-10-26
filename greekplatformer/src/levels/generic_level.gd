extends Node2D

@export var current_room:Area2D

var new_next_level

func next_level():
	current_room=new_next_level
	get_node("Camera").set_state("RoomTransition")
