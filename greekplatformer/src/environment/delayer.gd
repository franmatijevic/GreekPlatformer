extends Node

@export var delay:float=0.0

@export var connectedTo:Array[Node] = []

func action(togle:bool):
	if(togle):
		$Positive.start(delay)
	else:
		$Negative.start(delay)

func do_action(togle:bool):
	for i in connectedTo:
		i.action(togle)


func _on_positive_timeout() -> void:
	do_action(true)

func _on_negative_timeout() -> void:
	do_action(false)
