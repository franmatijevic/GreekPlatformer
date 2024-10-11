extends Node

class_name State

func player():
	return get_parent().get_parent()

func enter():
	pass

func exit():
	pass

func update_physics_process(_delta:float):
	pass

func update_process(_delta:float):
	pass
